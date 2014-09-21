class CouponsController < ApplicationController
  before_filter :check_credential
  after_filter :send_coupon_notifications, :only => [:create]

  respond_to :html, :json
  # GET /coupons
  # GET /coupons.json
  def index    
    if params[:uid].present? && params[:vid].present?
      friends_list = Friend.where(user_id: params[:uid]).map(&:friend_fb_id)
      friends_list = friends_list + [params[:uid]]
      @coupons = Coupon.where(:fb_id.in => friends_list, coupon_vendor: params[:vid], status: Coupon::COUPON_ACTIVE).all
    else
      friends_list = Friend.where(user_id: current_user.facebook_uid, status: Coupon::COUPON_ACTIVE).map(&:friend_fb_id) if current_user.present?
      friends_list = friends_list + [current_user.facebook_uid] if current_user.present?
      @coupons = current_user.present? ? Coupon.where(:fb_id.in => friends_list).all : Coupon.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupons, methods: [:user_name, :expire_text]}
    end
  end
  
  def send_coupon_notifications
    @g = Koala::Facebook::API.new(Koala::Facebook::OAuth.new("179716845394813","bdfca7d1c57344d6deec30f95e70d8f0").get_app_access_token)
    friends = Friend.where(user_id: current_user.facebook_uid).entries
    
    user_fb_ids = User.all.collect {|u| u.facebook_uid.to_s}
    friends.each do |friend|
      if user_fb_ids.include?(friend.friend_fb_id.to_s)
        @g.put_connections(friend.friend_fb_id, "notifications", template: "Checkout the coupon sent by you from your friend", href: "http://localhost:3000")    
      end  
    end
  end  
  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.json
  def new
    @coupon = current_user.coupons.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    @coupon = Coupon.find(params[:id])
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = current_user.coupons.new(params[:coupon])
    @coupon.fb_id = current_user.facebook_uid
    @coupon.user_name = current_user.full_name
    @coupon.expire_text = @coupon.expire_at.to_formatted_s(:short)
    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render json: @coupon, status: :created, location: @coupon }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.json
  def update
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to coupons_url }
      format.json { head :no_content }
    end
  end

  def update_status
    if current_user.present? && params[:code].present?
      coupon = Coupon.where(code: params[:code]).first
      coupon.status = Coupon::COUPON_INACTIVE if coupon.present?
      coupon.save if coupon.present?
      render :json => {"success"=>true}
    else      
      render :json => {"success"=>false}
    end
  end
end
