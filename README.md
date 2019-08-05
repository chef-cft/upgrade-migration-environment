# Chef Upgrade and Migration environment

## EAS based code to build an environment to demonstrate a Chef15 upgrade and Effortless Pattern Migration

### Supported Stories
* Upgrade and Migration to Chef15/Effortless

### Assumptions
* this environment is like a long running customer environment
  * tools already installed
  * pipelines already setup
  * chef software already setup
  * nodes checking in
  * everything managed
  * real certs / self signed too (to replicate reality)

### Requirements
* low overhead build that provides example to talk features or direction
* completely shows our end to end products and them running
* ability to walk full customer story
* avail 24/7 for anyone at chef
* serves as the UAT environment for Chef the Company, Chef EAS
* Use the best practice to build and deploy Chef products
* Only do EAS and newest version of Chef Software
* leverage as much previous work as possible

### Blocking work

* cannot do the upgrade/migration prototype until UAT env is up and functioning, and reproducible

### Architecture UAT (first pass)

![Architecture](environment.png)


#### Linux (Enterprise Workflow)

* chef-server
* automate
* bldr api
* supermarket
* chef workstation

* source control tool
  * ADO git
  * Bitbucket
* pipeline tool
  * ADO pipeline
  * Jenkins
* artifact store
  * Azure storage
  * Artifactory

* long running linux node
* long running windows node

* deployable N linux nodes
* deployable N windows nodes
