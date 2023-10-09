#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2021, Max Hösel <ansible@maxhoesel.de>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import absolute_import, division, print_function
from ansible.module_utils.basic import AnsibleModule
__metaclass__ = type

DOCUMENTATION = r"""
---
module: hello
author: Max Hösel (@maxhoesel)
short_description: Say Hi!
version_added: '0.1.0'
description: >
  Simple example module to check tests and doc generation
options:
  message:
    description: What should we say
    type: string
    default: "Hello World!"
"""

def main():
    module_args = dict(
        message=dict(type="string", default="Hello World!"),
    )
    module = AnsibleModule(module_args, supports_check_mode=True)
    module.exit_json(changed=False, message=module.params["message"])


if __name__ == "__main__":
    main()
