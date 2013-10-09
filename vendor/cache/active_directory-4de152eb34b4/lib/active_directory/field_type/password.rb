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
		class Password
			#
			# Encodes an unencrypted password into an encrypted password
			# that the Active Directory server will understand.
			#
			def self.encode(password)
				("\"#{password}\"".split(//).collect { |c| "#{c}\000" }).join
			end

			#
			# Always returns nil, since you can't decrypt the User's encrypted
			# password.
			#
			def self.decode(hashed)
				nil
			end
		end
	end
end
