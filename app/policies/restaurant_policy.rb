class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all

      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  # Inherited
  # def new?
  #   create?
  # end

  def create?
    user
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    user_is_owner? || user_is_admin?
  end

  def user_is_owner?
    # restaurant.user == current_user
    record.user == user
  end

  def user_is_admin?
    user.admin
  end

end
