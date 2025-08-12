import os
import boto3
from datetime import datetime, timedelta

def get_aws_cost_explorer_data(start_date, end_date):
    """
    AWS Cost Explorer에서 비용 데이터를 가져옵니다.
    """
    client = boto3.client('ce') # Cost Explorer 클라이언트 초기화

    try:
        response = client.get_cost_and_usage(
            TimePeriod={
                'Start': start_date,
                'End': end_date
            },
            Granularity='DAILY', # 일별 비용
            Metrics=['UnblendedCost'], # 실제 발생한 비용
            # Filter={ # 특정 서비스나 태그 등으로 필터링 가능
            #     "Dimensions": {
            #         "Key": "SERVICE",
            #         "Values": ["Amazon Elastic Compute Cloud - Compute"]
            #     }
            # }
        )
        return response
    except Exception as e:
        print(f"AWS Cost Explorer에서 데이터를 가져오는 중 오류 발생: {e}")
        return None

def analyze_costs(cost_data):
    """
    가져온 비용 데이터를 분석하고 보고서를 생성합니다.
    """
    if not cost_data:
        print("비용 데이터를 가져오지 못했습니다.")
        return

    total_cost = 0.0
    daily_costs = {}

    for result_by_time in cost_data['ResultsByTime']:
        date = result_by_time['TimePeriod']['Start']
        amount = float(result_by_time['Total']['UnblendedCost']['Amount'])
        currency = result_by_time['Total']['UnblendedCost']['Unit']
        total_cost += amount
        daily_costs[date] = {'amount': amount, 'unit': currency}
        print(f"날짜: {date}, 비용: {amount:.2f} {currency}")

    print("\n--- 비용 분석 요약 ---")
    print(f"총 비용: {total_cost:.2f} {currency}")

    # 특정 임계치를 넘으면 경고 메시지 출력
    cost_threshold_str = os.getenv('COST_THRESHOLD')
    if cost_threshold_str:
        try:
            cost_threshold = float(cost_threshold_str)
            if total_cost > cost_threshold:
                print(f"🚨 경고: 총 비용 ({total_cost:.2f} {currency})이 임계치 ({cost_threshold:.2f} {currency})를 초과했습니다!")
        except ValueError:
            print("환경 변수 COST_THRESHOLD가 유효한 숫자가 아닙니다.")

    if total_cost > 0:
        print("비용이 발생했습니다. 상세 내역을 확인해주세요.")
    else:
        print("비용 발생 내역이 없습니다.")

    # 추가적인 비용 발생 조건 및 알림 로직 (예: 특정 서비스 비용 급증)
    # 이곳에 비즈니스 로직에 맞는 추가적인 점검을 구현할 수 있습니다.
    # 예: 특정 서비스의 어제 대비 오늘 비용 증감률 분석
    # 예: 특정 리소스 태그별 비용 분석 등

if __name__ == "__main__":
    # 오늘 날짜
    today = datetime.now()
    # 어제 날짜 (Cost Explorer는 보통 24시간 정도의 지연이 있을 수 있으므로 어제 데이터 조회)
    yesterday = today - timedelta(days=1)
    
    start_date = yesterday.strftime('%Y-%m-%d')
    end_date = today.strftime('%Y-%m-%d') # Cost Explorer end_date는 포함하지 않음

    print(f"AWS Cost Explorer에서 {start_date} ~ {end_date} 기간의 비용 데이터 조회 중...")
    cost_data = get_aws_cost_explorer_data(start_date, end_date)
    analyze_costs(cost_data)
