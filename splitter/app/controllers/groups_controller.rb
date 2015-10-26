class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save!
      flash[:notice] = "Success"
      redirect_to group_path(@group.id)
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def add_users
    @group = Group.find(params[:id])
    @user = User.where(name: params[:name]).first
    membership = Membership.new(user_id: @user.id, group_id: @group.id)
    if membership.save
      flash[:notice] = 'Added user'
      redirect_to group_path
    else
      flash[:notice] = 'Could not find the user in DB'
      redirect_to group_path
    end
  end

  def add_transaction
    group = Group.find(params[:id])
    creditor = User.where(name: params[:creditor]).first rescue nil
    debtor = User.where(name: params[:debtor]).first rescue nil
    if !valid_group_members?(creditor,debtor,group)
      flash[:notice] = 'Invalid group members. Transaction not saved.'
      redirect_to group_path(params[:id])
    end
    transaction = Transaction.new(creditor_id: creditor.id, debtor_id: debtor.id, group_id: params[:id], note: params[:note], amount: params[:amount])
    if transaction.save
      flash[:notice] = 'Transaction saved succefully'
      redirect_to group_path(params[:id])
    else
      flash[:notice] = 'User not present in DB'
      redirect_to group_path(params[:id])
    end
  end

  def simplify_debts
    group = Group.find(params[:id])
    debugger
    SimplifyService.new(group.transactions).settle_up
    flash[:notice] = 'Debts Simplified'
    redirect_to group_path(group.id)
  end
  private

  def group_params
    params.require(:group).permit(:name)
  end

  def valid_group_members?(creditor,debtor,group)
    Membership.where(user_id: creditor.id, group_id: group.id).exists? && Membership.where(user_id: debtor.id, group_id: group.id).exists?
  end

end
