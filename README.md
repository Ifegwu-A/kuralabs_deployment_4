# Deployment 4!
In this deployment I will using Terraform to build AWS infrastructure and deploy a flask app with Jenskin. 
-----------------------------------------------------------------------------------------------------------

## GoalS
* Ceate an EC2 instance.
* Install Jenkins & Terraform in the EC2 instance.
* Create credentials on Jenkins and GitHub.
* Build a pipeline on Jenkins.
* Using Terraform create a VPC. 
* Deploy your app in the newly created VPC.
* Add my alerts from my Deployments 3 to the pipeline.
---------------------------------------------------------------------------------------------------------------

## Process
* Created the AWS VPC and EC2 instance with Terraform.

<img width="576" alt="Tform" src="https://user-images.githubusercontent.com/108818957/199493424-25b451bd-b87b-4b40-a479-883260471bf3.png">

* Intsalled Jenkins and Terraform in my ubuntu ec2 instance.
* Created my Jenkin pipeline via github repository.
* Added the destory stage to jenkins file on github.

![Screenshot Capture - 2022-11-02 - 09-11-42](https://user-images.githubusercontent.com/108818957/199498323-cb508ee9-bb32-44c4-9369-ebc6486fb2b0.png)

* Added the Jenkins alert. 
<img width="576" alt="1" src="https://user-images.githubusercontent.com/108818957/199499437-579a6d67-9f34-4c41-895a-209d30f9e77e.png">
* Deployed the app on the new VPC and initiated a successiful build on Jenkins.

![Screenshot Capture - 2022-11-01 - 18-23-52](https://user-images.githubusercontent.com/108818957/199500382-29373bfd-8d0b-48ec-9db9-e77d6f88a8ba.png)

* Successful deployment of the url-shortener application. 

![Screenshot Capture - 2022-10-14 - 18-44-00](https://user-images.githubusercontent.com/108818957/199501257-5ed99c5e-d9f2-456f-8baa-d6217eb79b14.png)

## Diagram of the Deployment


![Screenshot Capture - 2022-11-01 - 17-51-33](https://user-images.githubusercontent.com/108818957/199501643-e76d8293-743d-495b-b4ee-de57fb370144.png)


