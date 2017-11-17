class Ability
  include CanCan::Ability
  
  def initialize(user)
    unless user.nil?
      role = user.roles.last.name
      parent_id = user.parent_id
      
      if role == AppConstants::SUPER_ADMIN
        super_admin user
      elsif role == AppConstants::COMPANY
        company user
      elsif role == AppConstants::MASTER
        master user, parent_id
      elsif role == AppConstants::CLIENT
        grand_parent_id = user.parent.parent_id
        client user, parent_id, grand_parent_id
        
      end
      
      all_users user
    end
  end
  
  def super_admin(user)
    can :manage, User, parent_id: user.id
    can [:add_user], User, parent_id: user.id
  end
  
  def company(user)
    can :manage, User, parent_id: user.id

    can :manage, Event, user_id: user.id#, is_deleted: false
    can :manage, EventType, user_id: user.id#, is_deleted: false
    
    can [:index], Competition, event: {user_id: user.id }
    # can [:new, :create, :edit, :update, :destroy], Competition, event: {is_closed: false }
    can [:new, :create, :edit, :update, :destroy], Competition

    can [:join], UserCompetition, competition: {event: {user_id: user.id }}
    
    can [:index, :show], Account
  end
  
  def master(user, parent_id)
    can :manage, User, parent_id: user.id

    can [:index], Event, user_id: parent_id
    can [:index], Competition, event: {user_id: parent_id }

    can [:join], UserCompetition, competition: {event: {user_id: parent_id }}

    can [:index, :show], Account
  end
  
  def client(user, parent_id, grand_parent_id)
    can [:index], User
    can [:index], Event, user_id: grand_parent_id
    can [:index], Competition, event: {user_id: grand_parent_id }
    can [:join], UserCompetition, competition: {event: {user_id: grand_parent_id }, is_closed: false}
    can [:new, :create], UserCompetition#, competition: {is_closed: false}
    can [:index], UserCompetition, competition: {event: {user_id: grand_parent_id }}

    can [:index, :show], Account
  end


  def all_users(user)
    can [:update], User, id: user.id
    cannot [:destroy], User
  end
  
end
