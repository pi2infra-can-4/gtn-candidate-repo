## **The Brief**

You have just joined **Northwind**, an e-commerce startup launching its flagship store next week. We are currently manually clicking through the AWS Console, which is not sustainable. We need a resilient, 2-tier architecture that can handle traffic spikes and database connections

securely.

Your goal is to define this infrastructure using Terraform.

**Constraints:**

- **Quality**: Must be modularized for maintainability and strictly adhere to DRY principles.
- **Security**: Implement security best practices throughout the architecture.
- **Environment**:
    - Begin with starter repository to focus on logic.
    - Use the provided AWS credentials for this assessment.

### Part 1: The Foundation

- **Objective:** Establish the secure networking layer and the database.
- **Requirements:** Please write the Terraform configuration to provision the following:
- **VPC:** Create a custom VPC with the CIDR block `192.168.0.0/16`.
- **Subnets:** Create a total of four subnets: Two **Public Subnets** and two **Private Subnets** distributed across different Availability Zones.
- **Routing:** Configure a Route Table to ensure only the Public Subnets have direct access to the Internet Gateway.
- **Database:** Deploy a **PostgreSQL** RDS instance configured with a `db.t3.micro` class.
- **Security:** Ensure the database is placed inside the Private Subnets and accepts traffic **only** from the VPC CIDR (not the open internet).

### Part 2: The Application Layer

- **Objective:** Deploy the application servers using standard modular components.
- **Context:** The database is up and running in the private zone. Now we need to deploy the web servers. To save time and adhere to "Don't Repeat Yourself" (DRY) principles, we want to use community modules where possible.
- **Requirements:** Modify your code to add the compute layer:
    - **Load Balancer:** Deploy an HTTP (Port 80) ALB using the official `terraform-aws-modules` library.
    - **Launch Template:** Configure a `t3.micro` **Amazon Linux 2023** instance with User Data to install Nginx.
    - **Health Check:** Ensure the Target Group is configured to check the root path `/` and expects a `200` response code.
    - **Integration:** Provision an Auto Scaling Group (min: 1, max: 3) and register it with the Load Balancer target group.