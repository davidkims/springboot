# Spring Boot Setup

## Creating a Project

Use the Spring Initializr to generate a project:

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web,actuator | tar -xzvf -
```

## Running

```bash
./mvnw spring-boot:run
```

Dependabot will update dependencies listed in `pom.xml` or `build.gradle`.
