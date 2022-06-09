#######################################
# CHALLET Olivier
# Create Ansible Role Folder
#######################################

$folder = Read-Host -Prompt 'Quelque est le chemin complet du futur role ? (Par défault : C:\Users\USERNAME\Documents\Ansible)'
if ($folder -eq '') {
    $folder = "$home/documents/"
}

$branchName = Read-Host -Prompt 'Quelque est le nom de la branche ? (exemple : BRANCH-XX)'
if ($branchName -eq '') {
    $branchName = 'BRANCH-NEW'
}

$roleName = Read-Host -Prompt 'Quelque est le nom du role ? (exemple : role_win_XX)'
if ($roleName -eq '') {
    $roleName = 'role_NEW'
}

$description = Read-Host -Prompt 'Description de votre rôle : (exemple : This role execute powerhsell script to add computer...)'

New-Item $folder$branchName -itemType Directory
New-Item $folder$branchName"\roles\"$roleName"\defaults" -itemType Directory
New-Item $folder$branchName"\roles\"$roleName"\files" -itemType Directory
New-Item $folder$branchName"\roles\"$roleName"\handlers" -itemType Directory
New-Item $folder$branchName"\roles\"$roleName"\meta" -itemType Directory
New-Item $folder$branchName"\roles\"$roleName"\tasks" -itemType Directory
New-Item $folder$branchName"\roles\"$roleName"\templates" -itemType Directory
New-Item $folder$branchName"\roles\"$roleName"\tests" -itemType Directory
New-Item $folder$branchName"\roles\"$roleName"\vars" -itemType Directory

New-Item $folder$branchName"\roles\"$roleName"\README.md" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\.travis.yml" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\defaults\main.yml" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\files\empty" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\handlers\main.yml" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\meta\main.yml" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\tasks\main.yml" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\templates\empty" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\tests\test.yml" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\tests\inventory" -itemType File
New-Item $folder$branchName"\roles\"$roleName"\vars\main.yml" -itemType File

Set-Content -Value "--- #default main file for $roleName" -Path $folder$branchName"\roles\"$roleName"\defaults\main.yml"
Set-Content -Value "--- #handler main file for $roleName" -Path $folder$branchName"\roles\"$roleName"\handlers\main.yml"
Set-Content -Value "--- #task main file for $roleName" -Path $folder$branchName"\roles\"$roleName"\tasks\main.yml"
Set-Content -Value "---" -Path $folder$branchName"\roles\"$roleName"\tests\test.yml"
Set-Content -Value "--- #var main file for $roleName" -Path $folder$branchName"\roles\"$roleName"\vars\main.yml"

Set-Content -Value "galaxy_info:
  role_name: $roleName
  author: CHALLET Olivier
  description: $description
  company: E-3S

  # If the issue tracker for your role is not on github, uncomment the
  # next line and provide a value
  # issue_tracker_url: http://example.com/issue/tracker

  # Some suggested licenses:
  # - BSD (default)
  # - MIT
  # - GPLv2
  # - GPLv3
  # - Apache
  # - CC-BY
  license: license BSD

  min_ansible_version: 1.2

  # If this a Container Enabled role, provide the minimum Ansible Container version.
  # min_ansible_container_version:

  # Optionally specify the branch Galaxy will use when accessing the GitHub
  # repo for this role. During role install, if no tags are available,
  # Galaxy will use this branch. During import Galaxy will access files on
  # this branch. If Travis integration is configured, only notifications for this
  # branch will be accepted. Otherwise, in all cases, the repo's default branch
  # (usually master) will be used.
  #github_branch:

  #
  # platforms is a list of platforms, and each platform has a name and a list of versions.
  #
  # platforms:
  # - name: Fedora
  #   versions:
  #   - all
  #   - 25
  # - name: SomePlatform
  #   versions:
  #   - all
  #   - 1.0
  #   - 7
  #   - 99.99

  galaxy_tags: []
    # List tags for your role here, one per line. A tag is a keyword that describes
    # and categorizes the role. Users find roles by searching for tags. Be sure to
    # remove the '[]' above, if you add tags to this list.
    #
    # NOTE: A tag is limited to a single word comprised of alphanumeric characters.
    #       Maximum 20 tags per role.

dependencies: []
  # List your role dependencies here, one per line. Be sure to remove the '[]' above,
  # if you add dependencies to this list." -Path $folder$branchName"\roles\"$roleName"\meta\main.yml"

Set-Content -Value "Role Name : $roleName
=========

$description

Requirements
------------

Nothing

Role Variables
--------------



Dependencies
------------

Nothing

License
-------

BSD

Author Information
------------------

CHALLET Olivier (E-3S)
" -Path $folder$branchName"\roles\"$roleName"\README.md"

Set-Content -Value "---
language: python
python: 2.7

# Use the new container infrastructure
sudo: false

# Install ansible
addons:
  apt:
    packages:
    - python-pip

install:
  # Install ansible
  - pip install ansible

  # Check ansible version
  - ansible --version

  # Create ansible.cfg with correct roles_path
  - printf '[defaults]\nroles_path=../' >ansible.cfg

script:
  # Basic role syntax check
  - ansible-playbook tests/test.yml -i tests/inventory --syntax-check

notifications:
  webhooks: https://galaxy.ansible.com/api/v1/notifications/
" -Path $folder$branchName"\roles\"$roleName"\.travis.yml"
