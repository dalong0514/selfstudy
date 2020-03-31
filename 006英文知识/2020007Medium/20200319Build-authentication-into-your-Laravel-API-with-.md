# Build authentication into your Laravel API with JSON Web Tokens (JWT)
Connor Leech

Dec 12, 2018 · 6 min read



tymondesigns/jwt-auth
In this tutorial we’re going to expand the API we built in the previous tutorial to include authentication. By default Laravel includes authentication for session based authentication. Check it out by looking at the Laravel docs on authentication:
At its core, Laravel’s authentication facilities are made up of “guards” and “providers”. Guards define how users are authenticated for each request. For example, Laravel ships with a session guard which maintains state using session storage and cookies. — Laravel 5.7 Authentication docs
Source code for what we’re working on
We can see the config for session based authentication under the “guards” section of config/auth.php:
/*
|-------------------------------------------------------------------
| Authentication Guards
|-------------------------------------------------------------------
|
| Next, you may define every authentication guard for your application.
| Of course, a great default configuration has been defined for you
| here which uses session storage and the Eloquent user provider.
...
'guards' => [
    'web' => [
        'driver' => 'session',
        'provider' => 'users',
    ],

    'api' => [
        'driver' => 'token',
        'provider' => 'users',
    ],
],
Cookies are great when the server and the client are on the same domain, but with API driven development we’re likely to have a server running in one place and a client, or multiple clients running on other domains. With multiple domains we can run into Cross Origin Resource Sharing (CORS) errors. When building an API it’s common practice to use JSON Web Tokens (JWT) instead. This means we’ll need to update our auth guards.
Install jwt-auth
In this tutorial we’re going to use tymondesigns/jwt-auth (docs) for our new authentication guard. It can be installed with composer:
$ composer require tymon/jwt-auth "1.0.*"
Laravel Passport is another package that does similar things to jwt-auth.
The jwt-auth composer package has a config file that we can publish:
$ php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider"
A new config file gets generated in config/jwt.php. Next step is to generate a secret key. We’ll use this key to sign all of our tokens.
$ php artisan jwt:secret
This command will add a JWT_SECRET value to our .env file. In order to use this jwt-auth package, our User model (or whatever model we’re using to authenticate) must implement the JWTSubject interface. That interface has two methods as we can see here:
<?php

/*
 * This file is part of jwt-auth.
 *
 * (c) Sean Tymon <tymon148@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Tymon\JWTAuth\Contracts;

interface JWTSubject
{
    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier();

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims();
}
In order to implement an interface you need to provide all of the methods of that interface in your class. That means for our User model to implement this interface it needs to have a getJWTIdentifier method and a getJWTCustomClaims method.
Read more about the structure of JSON Web Tokens here: https://jwt.io/introduction/
The subject claim will be a reference to our user. Eloquent provides a “getKey” method on our models that returns the value of the record’s primary key. For the default User table in Laravel the primary key is the “id” column. For the custom claims method, we’re not going to worry about that and instead return an empty array.
We also want to make sure that whenever we save the password we are saving the hashed version. We can do this by using a Laravel Mutator so that whenever we save a value to the “password” column we always save the hashed version.
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }
    public function setPasswordAttribute($password)
    {
        if ( !empty($password) ) {
            $this->attributes['password'] = bcrypt($password);
        }
    }    
    
    ...
That’s it! We’re successfully implementing the contract that we need to implement. In our config/auth.php file we need to specify that we’d like to use the jwt guard that this package provides:
    'defaults' => [
      'guard' => 'api',
      'passwords' => 'users',
    ],

    ...

    'guards' => [
      'api' => [
        'driver' => 'jwt',
        'provider' => 'users',
      ],
    ],
So our default auth guard is the “api” guard and that guard uses the “jwt” driver. This keeps us primarily using the built in Laravel auth functionality but powered by jwt-auth driver behind the scenes.
Build our routes and controller methods
We’re all set up to use the jwt driver as our authentication gaurd. Now we need to define some routes and controller methods. When someone posts to /api/register we’re going to create a user and log them in by sending back a token. When someone posts to /api/login we’re going to verify the credentials are legit and send back a token if they are.
Be sure to scope the Laravel documentation on manually authenticating users
First, define the routes in routes/api.php and create the corresponding controller with php artisan make:controller AuthController.
Route::post('/register', 'AuthController@register');

Route::post('/login', 'AuthController@login');
Route::post('/logout', 'AuthController@logout');
With these routes established, let’s check out how to implement the methods. Much of this is drawn directly from the tymondesigns/jwt-auth docs.
<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $user = User::create([
             'email'    => $request->email,
             'password' => $request->password,
         ]);

        $token = auth()->login($user);

        return $this->respondWithToken($token);
    }

    public function login()
    {
        $credentials = request(['email', 'password']);

        if (! $token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type'   => 'bearer',
            'expires_in'   => auth()->factory()->getTTL() * 60
        ]);
    }
}
Allow CORS
When a standalone frontend application sends request to your server the browser might sqwak about Cross Origin Resource Sharing (CORS). Install this package:
$ composer require barryvdh/laravel-cors
And add it to app/Http/Kernel.php in the $middleware array:
protected $middleware = [
    ...
    \Barryvdh\Cors\HandleCors::class,
];
Tests for JWT Authentication

Woohoo so it should all be working, but let’s write some tests to prove it.
<?php

namespace Tests\Feature;

use App\User;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Tests\TestCase;

class AuthenticationTest extends TestCase
{
    use DatabaseMigrations;

    public function setUp()
    {
        parent::setUp();

        $user = new User([
             'email'    => 'test@email.com',
             'password' => '123456'
         ]);

        $user->save();
    }

    /** @test */
    public function it_will_register_a_user()
    {
        $response = $this->post('api/register', [
            'email'    => 'test2@email.com',
            'password' => '123456'
        ]);

        $response->assertJsonStructure([
            'access_token',
            'token_type',
            'expires_in'
        ]);
    }

    /** @test */
    public function it_will_log_a_user_in()
    {
        $response = $this->post('api/login', [
            'email'    => 'test@email.com',
            'password' => '123456'
        ]);

        $response->assertJsonStructure([
            'access_token',
            'token_type',
            'expires_in'
        ]);
    }

    /** @test */
    public function it_will_not_log_an_invalid_user_in()
    {
        $response = $this->post('api/login', [
            'email'    => 'test@email.com',
            'password' => 'notlegitpassword'
        ]);

        $response->assertJsonStructure([
            'error',
        ]);
    }
}
Theses tests go through and test that we get the right response formats. Pushing up the source code to GitHub!
Source code on GitHub
Extra resources
These were helpful resources apart from the official documentation that were helpful in making sense of JWT authentication in Laravel.
Build a REST API with Laravel API resources by Chimezie Enyinnaya
laravel-api-boilerplate-jwt by Francesco Malatesta
🚀 If you’re a candidate on the job market or startup looking to hire in the Bay Area, feel free to create a profile on Employbl 🤝