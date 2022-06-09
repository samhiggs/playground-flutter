# Flutter App Backend

## Setting up gcloud
- Install
- create project & setup billing on project
- set project in `gcloud config set project flutter-app-spike`
- set region `gcloud config set compute/region australia-southeast1`
<br>  

As you go through the following steps, it will ask you if you want to 

## Deploying backend

### Simple deployment

Trying [this](https://blog.somideolaoye.com/fastapi-deploy-containerized-apps-on-google-cloud-run) first  
  
  - build on gcp cloud run `gcloud builds submit --tag gcr.io/flutter-app-spike/backend`
  - deploy onto serverless
  ```
  gcloud run deploy backend \
    --image  gcr.io/flutter-app-spike/backend \
    --platform managed \
    --region australia-southeast1 \
    --no-allow-unauthenticated
  ```
  - Then add yourself to the service (here it's called backend and )
  `gcloud run services add-iam-policy-binding backend --member=user:<YOUR_GMAIL_ACC> --role=roles/run.invoker`
- If you are accessing it in the browser, you will need to modify the header with the bearer token. download a firefox browser such as `simple-modify-headers` then configure it with the url pattern, and an Authorization key and `Bearer <token>` value. You will need to generate and copy the header by running `gcloud auth print-identity-token`.

### Setting up with persistent storage


### Setting up authentication/Authorization

- Start with no access as above (--no-allow-unauthenticated)
- Add a user `gcloud run services add-iam-policy-binding backend --member=user:higgzy77@gmail.com --role=roles/run.invoker`




### Authenticating between app and backend
https://cloud.google.com/run/docs/tutorials/secure-services  
Setting up end user auth https://cloud.google.com/run/docs/tutorials/identity-platform  




