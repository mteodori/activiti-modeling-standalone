ARG VERSION=7.0.0.Beta4

FROM activiti/activiti-modeling-app:$VERSION as FRONTEND
FROM activiti/activiti-cloud-modeling:$VERSION

COPY --from=FRONTEND /usr/share/nginx/html /public

ENV SPRING_RESOURCES_STATICLOCATIONS=file:/public
ENV SECURITY_BASIC_ENABLED=false
ENV MANAGEMENT_SECURITY_ENABLED=false
ENV ACT_KEYCLOAK_PATTERNS=/disabled

