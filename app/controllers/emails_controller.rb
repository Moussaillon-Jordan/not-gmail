class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def create
    @email = Email.create(object: Faker::Book.title, body: Faker::ChuckNorris.fact, read: false)

    respond_to do |format|
      format.html {
        if @email.save
          redirect_to root_path
          flash[:notice] = "Nouvel Email Reçu !"
        else
          redirect_to root_path
          flash[:notice] = "Une erreur est survenue veuillez réessayer"
        end
      }
      format.js { }
    end
  end

  def show
    @email = Email.find(params[:id])
    respond_to do |format|
      format.html { redirect_to emails_path(@email.id) }
      format.js { }
    end
  end

  def destroy
  @email = Email.find(params[:id])
  @email.destroy
  respond_to do |format|
    format.html { redirect_to root_path }
    format.js { }
  end
end

  private

  def email_params
    params.permit(:read)
  end

end
