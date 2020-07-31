import Vapor

struct Registrations: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.post("", use: collect)
        routes.get("", use: getAll)
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<[RegistrationFormular]> {
        RegistrationModel
            .query(on: req.db)
            .all()
            .map { $0.map { .init(model: $0) } }
    }
    
    func collect(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        try req
            .content
            .decode(RegistrationFormular.self)
            .model
            .save(on: req.db)
            .map { .ok }
    }
    
    struct RegistrationFormular: Content {
        let name: String
        let email: String
        let comment: String
        
        var model: RegistrationModel {
            .init(
                name: name,
                email: email,
                comment: comment
            )
        }
        
        init(model: RegistrationModel) {
            self.name = model.name
            self.email = model.email
            self.comment = model.comment
        }
    }
}
