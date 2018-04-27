module Access
  class PermissionService
    def initialize(user = nil, permission = {})
      # permision - Hash { name: Symbol, type: String, resources: Array }
      # user - User class
      # role - Role class or Role name
      @user = user
      @action_name = permission[:name]
      @action_type = permission[:type]
      @action_resources = permission[:resources] || []
    end

    def perform
      # return if permission exists
      return 'error' if Access.granted?(@user, @action_name)
      create_permission
    end

    private

    def create_permission
      raise 'Called abstract method: create_permission'
    end
  end
end
