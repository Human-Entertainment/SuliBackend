import Fluent
import Vapor

func routes(_ app: Application) throws
{
    let registration = app.grouped("registration")
    try registration.register(collection: Registrations())
}
