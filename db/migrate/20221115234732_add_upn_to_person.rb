class AddUpnToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :entities, :ad_upn, :string, after: :iam_id
    add_column :entities, :ad_proxy_addresses, :string, after: :ad_upn # Proxy Addresses contains any previous UPNs
  end
end
