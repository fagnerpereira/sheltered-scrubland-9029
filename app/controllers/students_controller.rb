class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    Student.transaction do
      @student = Student.new(student_params)

      respond_to do |format|
        if @student.save
          classroom = @student.classrooms.new(classroom_params)
          if classroom.save
            format.html { redirect_to @student, notice: t(:successfully_created, scope: [:panel, :notices]) }
            format.json { render :show, status: :created, location: @student }
          end
        end
        format.html { render :new, status: :bad_request }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: t(:successfully_updated, scope: [:panel, :notices]) }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: t(:successfully_destroyed, scope: [:panel, :notices]) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render text: 'Not Found', status: :not_found 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :register_number, :status)
    end

    def classroom_params
      params.require(:classroom).permit(:course_id)
    end
end
