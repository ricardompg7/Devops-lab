# README

## Synopsis

_This role execute the upgrade of "IBM Tiberia Network/Omnix Web GUI" component on the remote servers (M&E DevOps team Lab) from one version to another. This role must be run through the Ansible Tower._

## Variables

* _Upgrade of all Network components will be performed with 'ncosys' user which is configured under the playbook to be used._
* _All the files for the upgrade should be uploaded under Artifactory manually (.zip archives, .xml configs, etc)._
* _All the connection between Network servers and Artifactory can be performed through the proxy._
* _Artifactory server: https://na.artifactory.taas.Test.net/artifactory (new artifactory server: https://Test.jfrog.io/)_


Variable | Default| Comments
----------|-----------------|--------
**proxy** (string) | http://10.175.34.11:3128 | Proxy, which can be used during the execution.
**artifactory_url** (string) | https://na.artifactory.taas.Test.net/artifactory | Artifactory Server URL.
**temp_path** (string) | /temporary/WebGUI | This variable is identifying which path will be used to store all the files for the upgrade.
**temp_folder** (string) | FP28test| Folder, which will be created automatically to store the upgrade configurations and files
**package_path** (string) | gts-mneaas-files-generic-local/mneaas-autobuild/Packages/Omnix-v8.1.0-WebGUI-FP27-IM-Extensions-linux64-UpdatePack.codesigned.zip | The full path to the Artifactory upgrade Package.
**package_name** (string) | Omnix-v8.1.0-WebGUI-FP27-IM-Extensions-linux64-UpdatePack.codesigned.zip | This variable displays archive name, which will be used for the upgrade.
**sub_package_name** (string) | Omnix-v8.1.0-WebGUI-FP27-IM-Extensions-linux64-UpdatePack.zip | This variable is used to store the package name, which will be used for the upgrade.
**artifactory_username** (string) | - | Artifactory user, to download package from the Artifactory server.
**artifactory_password** (password) | - | Artifactory user's password
**config_xml_path** (string) | gts-mneaas-files-generic-local/mneaas-autobuild/Packages/OmnixWebGUI_FP28test_update_response.xml | The full path to the Artifactory Server with .xml configuration file.
**config_xml_name** (string) | OmnixWebGUI_FP28test_update_response.xml | Configuration file .xml full-name
**imcl_path** (string) | /home/ncosys/IBM/InstallationManager/eclipse/tools/imcl | Path where the imcl installation is located on the sever.
**Jazzhome** (string) | /opt/IBM/JazzSM | Jazzhome environment variable

## Results from execution

_Here is a table with the return codes after execution._

Return Code Group | Return Code | Comments
----------|--------------|---------
n/a | 0 |  Execution of the playbook ended without errors
misconfiguration | 201 |  Invalid input variable found. Please refer to variables and check error message to determine which variable is missing or in incorrect format.
misconfiguration | 202 |  Missing Ansible Tower credentials in Job template. Please modify your Job template and add Ansible Tower credentials.
component_playbook | 301 | An unrecognized error occurred. Please open an issue with the execution details.
misconfiguration | 302 | Error while getting inventory from Tower (using API call ```$TOWER_HOST/api/v2/inventories/$INVENTORY_ID/```). Most probably the Tower credentials used in the Job template are incorrect. Check if there is correct Ansible Tower hostname value and login values. Second most common problem is insufficient Tower user permissions in configuration of the credentials for access AT API. Account must check those credentials. Least probably cause of this problem is that the Tower API is not accessible. In such case open incident ticket to HST team (team which manages Ansible Tower infrastructure), however that is the least probably cause.
misconfiguration | 303 | Error while getting inventory from Tower (using API call `$TOWER_HOST/api/v2/job_templates/{{ tower_job_template_id }}`). Most probably the Tower credentials used in the Job template are incorrect. Check if there is correct Ansible Tower hostname value and login values. Second most common problem is insufficient Tower user permissions in configuration of the credentials for access AT API. Account must check those credentials. Least probably cause of this problem is that the Tower API is not accessible. In such case open incident ticket to HST team (team which manages Ansible Tower infrastructure), however that is the least probably cause.
misconfiguration | 304 | Error while creating temporary folder on Tower. Check the value of variable `output_dir` - automation user probably does not have rights to access selected folder. Try to use another folder or use default value.
misconfiguration | 305 | Error while displaying temporary folder stats. Check the value of variable `output_dir` - automation user probably does not have rights to do this action on this folder. Try to use another folder or use default value.

## Procedure

_This role execute the upgrade of of "IBM Tiberia Network/Omnix Web GUI" component on the remote servers._
_If needed to create subchapters for description meaning of specific "complex" variables._

## Support

* To open a bug report or enhancement request please click the "New issue" button on the issues page and follow instructions in the template of the issue.
* Project leads:
  * Yahor.Chyzheuski12@Test.com

## Deployment

**Diagram how network part is established:**

![image](https://media.github.Test.net/user/124930/files/097c37d6-8a58-47d1-b191-ae4f94301b2b)

## Upgrading process:

- You should proceed to the Ansible Tower (https://ansible-tower-web-svc-tower.apps.ocp6n.sr1.ag1.sp.ibm.local/)
- Under Ansible Tower Web interface at the left pannel find the tab named "Templates"
- Find template for the WebGui upgrade (the name is "m0e-mne-Network-webgui-upgrade") and press at the "Rocket sign" on the right like at the screenshot.
![image](https://media.github.Test.net/user/124930/files/3ca27850-df19-4412-b5aa-3fb0c84c03f3)

- Then you will be forwarded to fill the form to start the playbook. (All the parameters are very important, on the next step we will go through each of them) 

  ![image](https://media.github.Test.net/user/124930/files/06b1efb8-4e55-43d1-bbcb-f1b473f3c7d9)

- Each field has default value (it will help you to pass the correct value to variables )

## Prerequisites

* _Please, upload 2 files to the Artifactory for the upgrade._
* _First file is "Omnix-v8.1.0-WebGUI-*your version of upgrade*-IM-Extensions-linux64-UpdatePack.codesigned.zip"_
* _Second file is "update_response.xml" this is configuration file which is used for the upgrade. (please, configure this file and make any changes which is needed)._

## Examples

**More detailed parameters description:**

* Folder Path: this field identifying which directory will be used to store all the files for the upgrade. (usually it is already created on all the servers /temporary/WebGUI), but you can specify your custom path (ncosys user do not have permissions to create folders under /, it is better to use /tmp as an example)
* Folder Name: this paramter will be taken to create a folder with "Folder name" under "Folder path" to perform the upgrade.
* Path to the update_response.xml file: under this parameter should be passed the whole path to the file under which is store under Artifactory server.
* Name of update_response.xml file: this is the exact name of the update_response.xml file, which should be taken from the end of the parameter "Path to the update_response.xml file"
* Artifactory Package Path: this is a full path to the package (.zip file) which will be used for the WebGui upgrade
* Package Name: this parameter should have name of the package (.zip file) from the previous step
* Sub Package Name: each "Artifactory Package Path" contains (.zip file) inside the archive. Please, pass the name of the sub-package. 


**Test Scenario of WebGui upgrade:**

*Folder path*: /temporary/WebGUI

*Folder name*: FP28test

*Path to the update_response.xml file*: gts-mneaas-files-generic-local/mneaas-autobuild/Packages/
OmnixWebGUI_FP28test_update_response.xml

*Name of update_response.xml file*: OmnixWebGUI_FP28test_update_response.xml

*Artifactory Package Path*: gts-mneaas-files-generic-local/mneaas-autobuild/Packages/Omnix-v8.1.0-WebGUI-FP27-IM-Extensions-linux64-UpdatePack.codesigned.zip

*Package Name*: Omnix-v8.1.0-WebGUI-FP27-IM-Extensions-linux64-UpdatePack.codesigned.zip

*Sub Package Name*: Omnix-v8.1.0-WebGUI-FP27-IM-Extensions-linux64-UpdatePack.zip

### When the above parameters have been applied to in the ansible Tower, here the scenario what will be happened:

It means, that the path "/temporary/WebGUI" will be created on the remote server if it does not exist AND directory "FP28test" will be created for the upgrade. 

Finally, "/temporary/WebGUI/FP28test" this directory on the remote server will store all the files for the upgrade.

Also, configuration file for the upgrade will be "OmnixWebGUI_FP28test_update_response.xml".

The whole path to the file under Artifactory is "gts-mneaas-files-generic-local/mneaas-autobuild/Packages/OmnixWebGUI_FP28test_update_response.xml". The same approach for zip archives.

This screenshot better discribing how the variables in Ansible Tower was taken.

![image](https://media.github.Test.net/user/124930/files/0d21a94b-80ce-44ea-b5f6-f32a430192ed)

## License

[Test Intellectual Property](https://github.Test.net/Continuous-Engineering/CE-Documentation/blob/master/files/LICENSE.md)
