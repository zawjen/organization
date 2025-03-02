# Prompts - services

# Generic Service
We have to build [your-service-name] using NestJS which will be called by NextJs website and ReactNative mobile app. We are using Kong API Gateway which will be used as a gateway to access [your-service-name] from mobile or website. Kong API Gateway or [your-service-name] has to authenticate user using Keycloak.

Write a step by step process document for developer to create [your-service-name], deployed behind Kong API Gateway using Docker and Kubernetes.

Kong API Gateway should be configured to authenticate request using Keycloak.

The [your-service-name] should have a setting 'SERVICE-DOWN', which if set to true will return sample JSON from sample.json file.

Write endpoints for following features:

1- [endpoint 1]: This will return list of datasets
2- [endpoint 2]: This will post a dataset json to save

Create a NextJS and ReactNative forms to call [your-service-name].

[your-service-name] is only be authorized to be called from
1- NextJS website web-zawjen 
2- ReactNative mobile app mob-zawjen 
3- microservices dataset-service 

All other requests must be denied as they are DDoS attacks. 
Add necessary details so [your-service-name] stays highly secure and must be on SSL 
