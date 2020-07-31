import Vapor
import Fluent

final class RegistrationModel: Model {
    static var schema: String = "registrations"
    
    @ID var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "comment")
    var comment: String
    
    init(){}
    
    init(id: UUID? = nil,
         name: String,
         email: String,
         comment: String) {
        self.id = id
        self.name = name
        self.email = email
        self.comment = comment
    }
}

// MARK: - Migration

extension RegistrationModel {
    struct Migrate: Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(RegistrationModel.schema)
                .id()
                .field("name", .string, .required)
                .field("email", .string, .required)
                .field("comment", .string, .required)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(RegistrationModel.schema).delete()
        }
    }
}
