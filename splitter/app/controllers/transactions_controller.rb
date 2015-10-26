class TransactionsController < ApplicationController
  def new
  end

  def create
    creditor = User.where(name: params[:creditor]).first
    debtor = User.where(name: params[:debtor]).first
    transaction = Transaction.new(debtor_id: debtor.id, creditor_id: creditor.id, amount: params[:amount], note: params[:note])
    if transaction.save
      flash[:notice] = 'Transaction saved !'
      Publisher.publish("email", {to_email: debtor.email, subject: "You owe #{creditor.name} #{transaction.amount} for #{transaction.note}", body: "Test" })
    else
      flash[:notice] = 'Transaction not saved !'
    end
      redirect_to user_path(@current_user.id)
  end

  def destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:debtor, :creditor, :note, :amount, :group_id)
  end

end
