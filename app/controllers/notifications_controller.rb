class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.json
  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(params[:notification])

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.json
  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end

  def register_realtime_updates
    @updates = Koala::Facebook::RealtimeUpdates.new(:app_id => '179716845394813', :secret => 'bdfca7d1c57344d6deec30f95e70d8f0')                    
    # Rails.logger.info(callback_fb_url) 
    @updates.subscribe("user", "statuses", callback_fb_url, "random12345") if @updates.app_access_token.present?        
  end

  def send_notification
    place = "KFC"
    @g = Koala::Facebook::API.new(Koala::Facebook::OAuth.new("179716845394813","bdfca7d1c57344d6deec30f95e70d8f0").get_app_access_token)
    @g.put_connections("100002137135495", "notifications", template: "Checkout your friends discount coupon of #{place}", href: "http://localhost:3000")
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def callback_fb    
    Koala::Facebook::RealtimeUpdates.meet_challenge(@params, "random12345")
  end

  def receive_update
    if @oauth.validate_update(request.body, headers)
      # process update from request.body
    else
      render text: "not authorized", status: 401
    end
  end

  def test
    @token = "517631738373364|Il8yKf-ywhIgBBwgs_ZZPbHnh94"    
    render :text => @token
  end
end
