import Vapor

func migration(_ app: Application) {
    app.migrations.add(RegistrationModel.Migrate())
}
