class ClassRoomsController < ApplicationController
  before_action :set_class_room, only: [:show, :edit, :update, :destroy]

  # GET /class_rooms
  # GET /class_rooms.json
  def index
    @class_rooms = ClassRoom.all
  end

  # GET /class_rooms/1
  # GET /class_rooms/1.json
  def show
  end

  # GET /class_rooms/new
  def new
    @class_room = ClassRoom.new
  end

  # GET /class_rooms/1/edit
  def edit
  end

  # POST /class_rooms
  # POST /class_rooms.json
  def create
    @class_room = ClassRoom.new(class_room_params)

    respond_to do |format|
      if @class_room.save
        format.html { redirect_to @class_room, notice: 'Class room was successfully created.' }
        format.json { render :show, status: :created, location: @class_room }
      else
        format.html { render :new }
        format.json { render json: @class_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_rooms/1
  # PATCH/PUT /class_rooms/1.json
  def update
    respond_to do |format|
      if @class_room.update(class_room_params)
        format.html { redirect_to @class_room, notice: 'Class room was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_room }
      else
        format.html { render :edit }
        format.json { render json: @class_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_rooms/1
  # DELETE /class_rooms/1.json
  def destroy
    @class_room.destroy
    respond_to do |format|
      format.html { redirect_to class_rooms_url, notice: 'Class room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_room
      @class_room = ClassRoom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def class_room_params
      params.require(:class_room).permit(:name)
    end
end
