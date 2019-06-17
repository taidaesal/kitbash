#!/bin/bash
gem uninstall kitbash
gem build kitbash.gemspec
gem install ./kitbash-0.*
