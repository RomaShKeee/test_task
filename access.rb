require 'access/permission_service'
require 'access/user_permission_service'
require 'access/role_permission_service'

module Access
  # in real case input should be validated
  def granted?(user, permission_name, resources)
    return false if user.nil? && permission_name.nil?
    current_user = User.find(user.id)

    return true if current_user.permissions.where(
      name: permission_name.to_s,
      resources: [resources]
    )

    result = []
    current_user.roles.map do |role|
      result << true if role.permissions.where(
        name: permission_name.to_s,
        resources: [resources]
      )
    end
    result.include?(true)
  end

  module_function :granted?
end

# in Caller
current_user = User.find(params[:id])
role = Role.find(params[:role_id])
server_permission = { name: :reboot_server, type: 'READ', resources: nil }
file_permission = {
  name: :write_to_file,
  type: 'WRITE',
  resources: ['example.txt']
}

caller = Access::UserPermissionService.new(current_user, server_permission)
caller.perform

caller = Access::RolePermissionService.new(current_user, file_permission, role)
caller.perform

caller = Access::RolePermissionService.new(current_user, server_permission, 'Moderator')
caller.perform

Access.granted?(current_user, :reboot_server)
Access.granted?(current_user, :write_to_file, ['example.txt'])


