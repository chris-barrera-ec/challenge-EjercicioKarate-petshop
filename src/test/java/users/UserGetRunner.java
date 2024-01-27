package users;

import com.intuit.karate.junit5.Karate;
public class UserGetRunner {
    @Karate.Test
    Karate createUser() {return Karate.run("testCreateUser").relativeTo(getClass());}
    @Karate.Test
    Karate updateUser() {return Karate.run("testUpdateUser").relativeTo(getClass());}
    @Karate.Test
    Karate deleteUser() {return Karate.run("testDeleteUser").relativeTo(getClass());}
}
