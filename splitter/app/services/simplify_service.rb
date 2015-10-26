
#
# This class builds a graph of transactions and simplifies the expenses.
#
# @author [anirudh]
#
class SimplifyService
  #
  # [initialize description]
  # @param transactions ActiveRecords Transactions of users
  #
  # @return Hashy A graph built using hash
  def initialize(transactions)
    debugger
    @graph = Hashy.new
    transactions.each do |transaction|
      unless @graph.key?(transaction.debtor_id)
        @graph[transaction.debtor_id] = []
      end
      @graph[transaction.debtor_id].push(transaction.creditor_id).uniq!
    end
  end

  # Find strongly connected components and settle up amounts by subtracting min amount.
  def settle_up
    debugger
    strongly_connected_components = @graph.strongly_connected_components
    strongly_connected_components.each do |component|
      transactions = Transaction.where('creditor_id IN (?) AND debitor_id IN (?)', component, component)
      minimum_amount = transactions.minimum(:amount)
      transaction.update_all('amount = amount - minimum_amount')
    end
  end
end
