<h1 align="center">
  <a href="https://github.com/itsproutorg/wordpress-cloud-at-k8s">
    <!-- Please provide path to your logo here -->
    <img src="docs/images/logo.svg" alt="Logo" width="100" height="100">
  </a>
</h1>

<div align="center">
  WordPress Cloud at K8S
  <br />
  <a href="#about"><strong>Explore the docs »</strong></a>
  <br />
  <br />
  <a href="https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues/new?assignees=&labels=bug&template=01_BUG_REPORT.md&title=bug%3A+">Report a Bug</a>
  ·
  <a href="https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues/new?assignees=&labels=enhancement&template=02_FEATURE_REQUEST.md&title=feat%3A+">Request a Feature</a>
  .
  <a href="https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues/new?assignees=&labels=question&template=04_SUPPORT_QUESTION.md&title=support%3A+">Ask a Question</a>
</div>

<div align="center">
<br />

[![Project license](https://img.shields.io/github/license/itsproutorg/wordpress-cloud-at-k8s.svg?style=flat-square)](LICENSE)

[![Pull Requests welcome](https://img.shields.io/badge/PRs-welcome-ff69b4.svg?style=flat-square)](https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22)
[![code with love by itsproutorg](https://img.shields.io/badge/%3C%2F%3E%20with%20%E2%99%A5%20by-itsproutorg-ff1414.svg?style=flat-square)](https://github.com/itsproutorg)

</div>

<details open="open">
<summary>Table of Contents</summary>

- [About](#about)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Roadmap](#roadmap)
- [Support](#support)
- [Project assistance](#project-assistance)
- [Contributing](#contributing)
- [Authors & contributors](#authors--contributors)
- [Security](#security)
- [License](#license)

</details>

---

## About

WordPress Cloud at K8S is a GitHub repository that simplifies the deployment of WordPress instances in the cloud. The purpose of the project is to automate infrastructure setup and management, so users can focus on building their WordPress sites without worrying about the underlying technology.

The project includes GitHub Actions pipelines for deploying Kubernetes and Tekton, configuring MySQL, and deploying WordPress images. Each WordPress instance is set up as a read-only image with its own URI and SSL, and can be replicated as needed to handle different levels of traffic. WordPress instances can also be updated easily with new plugins or themes, and Tekton will automatically build and deploy the new version.

The repository is organized into several directories, including scripts for infrastructure setup, templates for pull requests, and a directory for committing WordPress definitions. Users can choose their cloud provider (AWS, GCP, or Azure) by selecting a flag in the repository.

We welcome contributors to join the project and help improve the infrastructure setup and management process for WordPress sites in the cloud. If you're interested in contributing, please see our [Contributing Guidelines](CONTRIBUTING.md). If you have any questions or issues, please [open an issue](https://github.com/itsproutorgua/wordpress-cloud-at-k8s/issues/new) on our GitHub repository.

Thank you for your interest in WordPress Cloud at K8S!




### Built With

* Terraform
* Ansible
* Kubernetes
* Tekton
* MySQL
* WordPress
* Docker
* GitHub Actions
* AWS/GCP/Azure

## Getting Started

To get started with WordPress Cloud at K8S, follow these steps:

1. Clone this repository:

    ```
    git clone https://github.com/<your-username>/wordpress-cloud-at-k8s.git
    ```

2. Choose your cloud provider (AWS, GCP, or Azure) by selecting the appropriate flag in the `setup_cloud_infra.sh` script. 

3. Run the `setup_cloud_infra.sh` script to deploy your Kubernetes cluster:

    ```
    sh setup_cloud_infra.sh
    ```

4. After the Kubernetes cluster is deployed, run the `setup_tekton.sh` script to deploy Tekton and configure it on the same repository:

    ```
    sh setup_tekton.sh
    ```

5. Next, run the `setup_mysql.sh` script to deploy MySQL on your Kubernetes cluster:

    ```
    sh setup_mysql.sh
    ```

6. Once MySQL is deployed, navigate to the `wordpress-definitions` directory and create your WordPress definition by modifying the `configset.yaml` file and committing your changes to the repository.

7. Finally, run the `deploy_wordpress.sh` script to build and deploy your WordPress instance:

    ```
    sh deploy_wordpress.sh
    ```

For detailed instructions on each step, please see our [Wiki page](https://github.com/itsproutorgua/wordpress-cloud-at-k8s/wiki).


### Prerequisites

Before you can use WordPress Cloud at K8S, you must have the following:

* A valid account with one of the following cloud providers: AWS, GCP, or Azure
* Terraform (v1.0.0 or higher) installed on your local machine
* Ansible (v2.9 or higher) installed on your local machine
* kubectl (v1.18.0 or higher) installed on your local machine
* Docker (v20.10.0 or higher) installed on your local machine


### Installation

To install WordPress Cloud at K8S, follow these steps:

1. Clone this repository:

    ```
    git clone https://github.com/itsproutorgua/wordpress-cloud-at-k8s.git
    ```

2. Create a new repository on your GitHub account.

3. Set up a remote repository for your local repository:

    ```
    git remote set-url origin https://github.com/<your-username>/<your-repo-name>.git
    ```

4. Update the `setup_cloud_infra.sh` script with your desired configuration parameters, such as cluster name, region, and instance type.

5. Create the following secrets in your GitHub repository to securely store your cloud provider credentials and other sensitive information:

    * `AWS_ACCESS_KEY_ID` - Your AWS access key ID
    * `AWS_SECRET_ACCESS_KEY` - Your AWS secret access key
    * `GCP_PROJECT_ID` - Your GCP project ID
    * `GCP_CREDENTIALS` - Your GCP service account credentials in JSON format
    * `AZURE_SUBSCRIPTION_ID` - Your Azure subscription ID
    * `AZURE_TENANT_ID` - Your Azure tenant ID
    * `AZURE_CLIENT_ID` - Your Azure client ID
    * `AZURE_CLIENT_SECRET` - Your Azure client secret

6. Enable GitHub Actions in your repository by creating a `.github/workflows` directory and copying the `deploy.yml` file from this repository:

    ```
    mkdir -p .github/workflows
    cp wordpress-cloud-at-k8s/.github/workflows/deploy.yml .github/workflows/deploy.yml
    ```

7. Commit and push your changes to your remote repository.

8. After GitHub Actions completes, you can access your WordPress site by visiting the external IP address of your Kubernetes cluster.

For more detailed instructions on how to configure GitHub Secrets and deploy your infrastructure, see our [Wiki page](https://github.com/itsproutorgua/wordpress-cloud-at-k8s/wiki).


## Usage

To deploy a new WordPress instance, follow these steps:

1. Create a new subset for WP-CLI in the `wordpress/` directory with the necessary configurations for your WordPress instance. For example:
    ```
    wordpress/subset-1/configset.yml
    site_url: https://example.com
    site_title: My Example Site
    admin_user: admin
    admin_email: example@example.com
    ```

2. Commit the new subset to your local git repository:
    ```
    $ git add wordpress/subset-1/configset.yml
    $ git commit -m "Add new subset for example.com"
    $ git push origin main
    ```

3. The Tekton pipeline will automatically trigger and deploy the new WordPress instance using the configurations specified in the subset.

4. Once the pipeline has completed, your new WordPress instance will be available at the specified `site_url` with the owner email `example@example.com` and the site title `My Example Site`.

## Roadmap

See the [open issues](https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues) for a list of proposed features (and known issues).

- [Top Feature Requests](https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues?q=label%3Aenhancement+is%3Aopen+sort%3Areactions-%2B1-desc) (Add your votes using the 👍 reaction)
- [Top Bugs](https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues?q=is%3Aissue+is%3Aopen+label%3Abug+sort%3Areactions-%2B1-desc) (Add your votes using the 👍 reaction)
- [Newest Bugs](https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues?q=is%3Aopen+is%3Aissue+label%3Abug)

## Support

Reach out to the maintainer at one of the following places:

- [GitHub issues](https://github.com/itsproutorg/wordpress-cloud-at-k8s/issues/new?assignees=&labels=question&template=04_SUPPORT_QUESTION.md&title=support%3A+)
- Contact options listed on [this GitHub profile](https://github.com/itsproutorg)

## Project assistance

If you want to say **thank you** or/and support active development of WordPress Cloud at K8S:

- Add a [GitHub Star](https://github.com/itsproutorg/wordpress-cloud-at-k8s) to the project.
- Tweet about the WordPress Cloud at K8S.
- Write interesting articles about the project on [Dev.to](https://dev.to/), [Medium](https://medium.com/) or your personal blog.

Together, we can make WordPress Cloud at K8S **better**!

## Contributing

First off, thanks for taking the time to contribute! Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make will benefit everybody else and are **greatly appreciated**.


Please read [our contribution guidelines](docs/CONTRIBUTING.md), and thank you for being involved!

## Authors & contributors

The original setup of this repository is by [IT Sprout](https://github.com/itsproutorg).

For a full list of all authors and contributors, see [the contributors page](https://github.com/itsproutorg/wordpress-cloud-at-k8s/contributors).

## Security

WordPress Cloud at K8S follows good practices of security, but 100% security cannot be assured.
WordPress Cloud at K8S is provided **"as is"** without any **warranty**. Use at your own risk.

_For more information and to report security issues, please refer to our [security documentation](docs/SECURITY.md)._

## License

This project is licensed under the **GNU General Public License v3**.

See [LICENSE](LICENSE) for more information.

