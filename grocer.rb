require 'pry'

def consolidate_cart(cart)
	return_hash = {}
  cart.each do |item|
		item.each do |key, values|
      return_hash[key] = {}
      return_hash[key][:price] = values[:price]
      return_hash[key][:clearance] = values[:clearance]
      return_hash[key][:count] = cart.count(item)
    end
	end
  return_hash
end

def apply_coupons(cart, coupons)
  #fix me
  coupons.each do |coupon|
    new_item_name = ""
    new_item_hash = {}
    cart.each do |item, info|
      if item == coupon[:item] && info[:count] >= coupon[:num]
        new_item_name = "#{coupon[:item]} W/COUPON"
        info[:count] -= coupon[:num]
        new_item_hash[:price] = coupon[:cost]
        new_item_hash[:clearance] = info[:clearance]
        new_item_hash[:count] = 1
      end
    end
		#check for existing item of same name:
		if cart.include?(new_item_name)
			cart[new_item_name][:count] += 1
		else
    	if new_item_hash != []
				cart[new_item_name] = new_item_hash
			end
		end
  end
	cart
end


def apply_clearance(cart)
  cart.each do |item, info|
		if info[:clearance]
			info[:price] = (info[:price] * 0.8).round(2)
		end
	end
end

def checkout(cart, coupons)
	final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
	total = 0
	final_cart.each do |item, info|
		if item != ""
			total = (total + info[:price] * info[:count]).round(2)
		end
	end
	if total > 100
		total = (total * 0.9).round(2)
	end
	total
end
