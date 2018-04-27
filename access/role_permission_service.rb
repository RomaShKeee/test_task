module Access
  class RolePermissionService < PermissionService
    def initialize(user, permission, role = nil)
      super(user, permission)
      @role = role
    end

    def create_permission
      create_user_role
      Permission.create(
        permitable: @role,
        name: @action_name.to_s,
        action_type: @action_type,
        resources: @action_resources
      )
      @user.roles << @role
    end

    def create_user_role
      return @role if @role.is_a? Role
      @role = Role.create(name: @role)
    end
  end
end
