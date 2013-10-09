#-- license
#
#  Based on original code by Justin Mecham and James Hunt
#  at http://rubyforge.org/projects/activedirectory
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#++ license

module ActiveDirectory
  module FieldType
    class Date
      #
      # Converts a time object into an ISO8601 format compatable with Active Directory
      # 
      def self.encode(local_time)
        local_time.strftime('%Y%m%d%H%M%S.0Z')
      end

      #
      # Decodes an Active Directory date when stored as ISO8601
      #
      def self.decode(remote_time)
        Time.parse(remote_time)
      end
    end
  end
end
