module TransactionsHelper

  def month_transactions(month, year)
    # Get all transactions for a particular month (and year), ordered by date of transaction ASC
    date = Date.new(year.to_i, Date::MONTHNAMES.index(month))
    @user.transactions.where('transaction_date >= ? and transaction_date <= ?',
                                                       date.beginning_of_month,
                                                       date.end_of_month).order(transaction_date: :ASC)
  end

  def sum_of_category_for_month(category, month, year)
    # Sum of all month's transactions for a specfic category
    month_transactions(month, year.to_i).where(category: category).sum(:price)
  end

  def total_sum_for_month(month, year, income)
    # Sum of all month's transactions
    date = Date.new(year.to_i, Date::MONTHNAMES.index(month))
    @user.transactions.joins(:category).where(category: { income: income }).where('transaction_date >= ? and transaction_date <= ?',
                             date.beginning_of_month,
                             date.end_of_month).sum(:price)
  end

  def sum_of_category_for_year(category, year)
    # Sum for a specific category for a full year
    date = Date.new(year.to_i)
    @user.transactions.where(category: category).where('transaction_date >= ? and transaction_date <= ?',
                                                       date.beginning_of_year,
                                                       date.end_of_year).sum(:price)
  end

  def total_sum_for_year(year, income)
    # Sum of all transactions for a year
    date = Date.new(year.to_i)
    @user.transactions.joins(:category).where(category: { income: income })
         .where('transaction_date >= ? and transaction_date <= ?',
                             date.beginning_of_year,
                             date.end_of_year).sum(:price)
  end

  def year_select
    # Select year shown
    year = if !@user.transactions.order(transaction_date: :asc).present? || @user.transactions.order(transaction_date: :asc).first.transaction_date.year > Date.today.year
             Date.today.year
           else
             @user.transactions.order(transaction_date: :asc).first.created_at.year
           end
    (year..Date.today.year).to_a
  end
end
