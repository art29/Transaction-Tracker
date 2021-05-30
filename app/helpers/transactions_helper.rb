module TransactionsHelper

  def month_transactions(month, year)
    date = Date.new(year.to_i, Date::MONTHNAMES.index(month))
    @user.transactions.where('transaction_date >= ? and transaction_date <= ?',
                                                       date.beginning_of_month,
                                                       date.end_of_month)
  end

  def sum_of_category_for_month(category, month, year)
    month_transactions(month, year.to_i).where(category: category).sum(:price)
  end

  def total_sum_for_month(month, year, income)
    date = Date.new(year.to_i, Date::MONTHNAMES.index(month))
    @user.transactions.joins(:category).where(category: { income: income }).where('transaction_date >= ? and transaction_date <= ?',
                             date.beginning_of_month,
                             date.end_of_month).sum(:price)
  end

  def sum_of_category_for_year(category, year)
    date = Date.new(year.to_i)
    @user.transactions.where(category: category).where('transaction_date >= ? and transaction_date <= ?',
                                                       date.beginning_of_year,
                                                       date.end_of_year).sum(:price)
  end

  def total_sum_for_year(year, income)
    date = Date.new(year.to_i)
    @user.transactions.joins(:category).where(category: { income: income })
         .where('transaction_date >= ? and transaction_date <= ?',
                             date.beginning_of_year,
                             date.end_of_year).sum(:price)
  end

  def year_select
    year = if !@user.transactions.order(transaction_date: :asc).present? || @user.transactions.order(transaction_date: :asc).first.transaction_date.year > Date.today.year
             Date.today.year
           else
             @user.transactions.order(transaction_date: :asc).first.created_at.year
           end
    (year..Date.today.year).to_a
  end
end
