class AddAdminToUsers < ActiveRecord::Migration[5.1]
  #default: false でデフォルトでは管理者になれないことを明示的に指定
  def change
    add_column :users, :admin, :boolean,default: false
  end
end
