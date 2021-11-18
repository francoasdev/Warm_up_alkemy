class UserRepresenter
    def initialize(user)
        @user = user
    end
    def as_json
    {
        id: user.id,
        email: user.email,
        token: AuthTokenService.call(user.id)
    }
    end
    private
        attr_reader :user
end