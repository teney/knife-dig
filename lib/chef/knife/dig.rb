#
# Author:: Frank Teney (<frank.teney@gmail.com>)
# Copyright:: Copyright (c) 2016 Frank Teney
#
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
module TeneyPlugins
  class Dig < Chef::Knife
    banner 'knife dig ROLE'

    def initialize(*args)
      @level = 0
      super
    end

    deps do
      require 'chef/role'
      require 'chef/search/query'
    end

    def run
      unless name_args.size == 1
        puts 'Please provide a role to dig'
        show_usage
        exit 1
      end

      role_name = name_args.first

      output "\n#{role_name} digging..."
      output 'role: ' + role_name
      dig_role(role_name)
    end # run

    def dig_role(role_name)
      @level += 1

      role = Chef::Role.load(role_name)
       role.run_list.each do |item|
        if item.role?
          output 'role: ' + item.name
          dig_role(item.name)
        elsif item.recipe?
          output 'recipe: ' + item.name
        end
      end
    end

    def loop_run_list(role)
      role.run_list.each do |item|
        if item.role?
          yield item
       end
      end
    end

    def output(msg)
      ui.msg(indent_str + msg)
    end

    def indent_str
      str = ''
      @level.times { str <<  ' ' }
      return str
    end
  end
end
