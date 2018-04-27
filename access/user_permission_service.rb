module Access
  class UserPermissionService < PermissionService
    def initialize(user, permission = {}, _role = nil)
      super(user, permission)
    end

    def create_permission
      Permission.create(
        permitable: @user,
        name: @action_name.to_s,
        action_type: @action_type,
        resources: @action_resources
      )
    end
  end
end
