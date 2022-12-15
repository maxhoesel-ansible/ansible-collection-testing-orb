# ansible-collection-testing-orb

[![CircleCI Build Status](https://circleci.com/gh/maxhoesel-ansible/ansible-collection-testing-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/maxhoesel-ansible/ansible-collection-testing-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/maxhoesel-ansible/ansible-collection-testing.svg)](https://circleci.com/orbs/registry/orb/maxhoesel-ansible/ansible-collection-testing) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/maxhoesel-ansible/ansible-collection-testing-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

A orb containing command and jobs related to testing Ansible collections.
Note that this orb makes a lot of assumptions about how your collection is structured, it was built with the maxhoesel-ansible collections in mind.

This repository is designed to be automatically ingested and modified by the CircleCI CLI's `orb init` command.

## Mock collection

This repository contains a mock ansible collection called `maxhoesel.orb_test` that is used to validate the functionality of commands.
Roles and plugins are taken from some of my other projects, they are used to ensure that doc builds/tox integration tests work.
See `plugins`,`roles` and `tox.ini` for details.

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/maxhoesel-ansible/ansible-collection-testing) - The official registry page of this orb for all versions, executors, commands, and jobs described.

[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using, creating, and publishing CircleCI Orbs.

### How to Contribute

This orb is mostly intended for use in my Ansible collections, however, I'm happy to take a look at any Issues or Pull Requests you might have!
### How to Publish An Update
1. Merge pull requests with desired changes to the main branch.
    - For the best experience, squash-and-merge and use [Conventional Commit Messages](https://conventionalcommits.org/).
2. Find the current version of the orb.
    - You can run `circleci orb info maxhoesel-ansible/ansible-collection-testing | grep "Latest"` to see the current version.
3. Create a [new Release](https://github.com/maxhoesel-ansible/ansible-collection-testing-orb/releases/new) on GitHub.
    - Click "Choose a tag" and _create_ a new [semantically versioned](http://semver.org/) tag. (ex: v1.0.0)
      - We will have an opportunity to change this before we publish if needed after the next step.
4.  Click _"+ Auto-generate release notes"_.
    - This will create a summary of all of the merged pull requests since the previous release.
    - If you have used _[Conventional Commit Messages](https://conventionalcommits.org/)_ it will be easy to determine what types of changes were made, allowing you to ensure the correct version tag is being published.
5. Now ensure the version tag selected is semantically accurate based on the changes included.
6. Click _"Publish Release"_.
    - This will push a new tag and trigger your publishing pipeline on CircleCI.
