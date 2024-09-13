class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]
  before_action :set_events, except: %i[ show destroy ]

  # GET /enrollments or /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # I pefer to use optimistic locking as an approach, because I think
  # the biggest risk is when the total of enrollments is reached,
  # while this it should allow the enrollment
  def create
    @enrollment = Enrollment.new(enrollment_params)
    @event = @enrollment.event
    respond_to do |format|
      Enrollment.transaction do
        @event.with_lock do
          create_enrollment format
        rescue ActiveRecord::StaleObjectError
          redirect_to @event, alert: "Event was updated, try again!"
        end
      end
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    @event = @enrollment.event
    respond_to do |format|
      Enrollment.transaction do
        @event.with_lock do
          update_enrollment format
        end
      rescue ActiveRecord::StaleObjectError
        redirect_to @event, alert: "Event was updated, try again!"
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment.destroy!

    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def create_enrollment(format)
      if @enrollment.save
        format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully created." }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end

    def update_enrollment(format)
     if @enrollment.update(enrollment_params)
        format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
     else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
     end
    end

    def set_events
      # Events are loaded from cache because the list
      # ou event pages are not updated frequently
      @events = Event.availables_cache
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:event_id, :email)
    end
end
