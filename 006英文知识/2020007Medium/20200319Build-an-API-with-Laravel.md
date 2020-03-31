# Build an API with Laravel 5.7
Connor Leech

Dec 8, 2018 · 7 min read

[Build an API with Laravel 5.7 - Employbl - Medium](https://medium.com/employbl/build-an-api-with-laravel-5-7-b3aa16ca2e69)

We’re hosting the Decemeber 2018 Laravel SF meetup at Stitch Labs. These are some show notes about installing Laravel and setting up an API.

If you’re new to Laravel, check out the Getting Started docs

Source code for this application.

Jump ahead: adding JWT auth

## 01. Create a new Laravel app

```
$ composer update
$ composer global require laravel/installer
$ laravel new december-2018-meetup
$ cd december-2018-meetup
```

## 02. Hook up the database

For this application we’re going to use SQLite. All that’s required to run SQLite locally is a blank file sitting in the database folder.

    $ touch database/database.sqlite

Now that we’ve created the raw database file, edit the .env file use sqlite. Delete the other database connection info and replace it:

```
DB_CONNECTION=sqlite
DB_DATABASE=database/database.sqlite
```

The .env file is not checked into version control and holds database connection info and API keys.

## 03. Create a database model, table and controller

For the next step we’re going to create a Task model with a few options:

    $ php artisan make:model Task --migration --resource --controller

The above options can be abbreviated to -mcr for the same effect.

These options:

--migration: This creates a file in database/migrations for creating the tasks table. We use this file to articulate what columns exist on the Task table.

--resource --controller: This creates a controller within app/Http/Controllers. The controller class will be fully equipped with CRUD methods.

To see all the options for any artisan command, prefix “help” to the command, like so:

    $ php artisan help make:model

Update the create task table migration to include a title and description field:

1『去 database/migrations/2020_03_19_134153_create_tasks_table.php。』

```
public function up()
{
    Schema::create('tasks', function (Blueprint $table) {
        $table->increments('id');
        $table->string('title');
        $table->text('description');
        $table->timestamps();
    });
}
```

The timestamps field, included by default, automatically add created\_at and updated\_at fields to the table in the database.

To actually run the migration and create our database tables use:

    $ php artisan migrate

## 04. Add routes

Now that we have a database, we need to be able to access our data and serve up JSON. These are defined in routes/api.php.

```
Route::get('/tasks', 'TaskController@all')->name('tasks.all');
Route::post('/tasks', 'TaskController@store')->name('tasks.store');
Route::get('/tasks/{task}', 'TaskController@show')->name('tasks.show');
Route::put('/tasks/{task}', 'TaskController@update')->name('tasks.update');
Route::delete('/tasks/{task}', 'TaskController@destory')->name('tasks.destroy');
```

Here we’re taking advantage of a Laravel feature called Route Model Binding. By passing in the id for a task resource we can inject the task itself into the controller below. If you don’t want to match on the id field and instead match on something like username, you could define getRouteKeyName to be username. More info in the docs above. This gives functionality similar to LinkedIn where your personal URL is /in/yourusername instead of /in/2398094392432 which would be a user id.

3『[Routing - Laravel - The PHP Framework For Web Artisans](https://laravel.com/docs/5.7/routing#route-model-binding) | [Database Testing - Laravel - The PHP Framework For Web Artisans](https://laravel.com/docs/5.7/database-testing#writing-factories)』

## 05. Define the actions in the controller

Now that we have route endpoints set up we need to actually do things when users make API calls. These actions are defined in the TaskController referenced above:

```
<?php

namespace App\Http\Controllers;

use App\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function index()
    {
        $tasks = Task::all();

        return response()->json($tasks);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required',
            'description' => 'required'
        ]);

        $task = Task::create($request->all());

        return response()->json([
            'message' => 'Great success! New task created',
            'task' => $task
        ]);
    }

    public function show(Task $task)
    {
        return $task;
    }

    public function update(Request $request, Task $task)
    {
        $request->validate([
           'title'       => 'nullable',
           'description' => 'nullable'
        ]);

        $task->update($request->all());

        return response()->json([
            'message' => 'Great success! Task updated',
            'task' => $task
        ]);
    }

    public function destroy(Task $task)
    {
        $task->delete();

        return response()->json([
            'message' => 'Successfully deleted task!'
        ]);
    }
}
```

In order for creating tasks to work, we need to specify on the Task model what fields we can write to:

```
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    protected $fillable = [
        'title',
        'description'
    ];
}
```

If you want to make all fields writable on a model you could instead do protected \$guarded = []. For our purposes, either one will work. The purpose of this extra check is to protect against Mass Assignment vulnerabilities where malicious users could write to fields that you don’t expect them to.

Woohoo! After all that it works! But don’t take my word for it. Let’s write some tests.

## Testing

### 1A. Create a test

Really tests should come first. First generate the test.

    $ php artisan make:test TaskTest

To run all of the tests use ./vendor/bin/phpunit from the command line. The default test will pass because it asserts true is true.

When writing tests it’s very helpful to rely on the die and dump command dd(). This will output what you specify and stop the program execution.

We’ll also want to specify more information about our testing database. In phpunit.xml add two lines toward the bottom of the file:

```
    ...
    <php>
        <env name="APP_ENV" value="testing"/>
        <env name="BCRYPT_ROUNDS" value="4"/>
        <env name="CACHE_DRIVER" value="array"/>
        <env name="MAIL_DRIVER" value="array"/>
        <env name="QUEUE_CONNECTION" value="sync"/>
        <env name="SESSION_DRIVER" value="array"/>
        <env name="DB_CONNECTION" value="sqlite"/>
        <env name="DB_DATABASE" value=":memory:"/>
    </php>
</phpunit>
```

This specifies connecting to a SQLite database for testing that’s stored in memory.

1『单元测试的配置。』

### 1B. Create a factory

To simplify creating tasks in our tests we can use Model Factories.

    $ php artisan make:factory TaskFactory --model=Task

These factories can be used for seeding your development database and have automatic access to the faker php library. This is helpful for mocking out names, addresses, email addresses, text and more. The factories are located in the database/factories folder.

```
<?php

use Faker\Generator as Faker;

$factory->define(App\Task::class, function (Faker $faker) {
    return [
        'title'       => $faker->sentence(),
        'description' => $faker->text()
    ];
});
```

### 1C. (optional) Create a seeder

Then create a seeder to check it works:

    $ php artisan make:seeder TaskSeeder

And the code for the seeder will invoke the factory to create ten unique tasks:

```
<?php

use App\Task;
use Illuminate\Database\Seeder;

class TaskSeeder extends Seeder
{
    public function run()
    {
        factory(Task::class, 10)->create();
    }
}
```

We can use the php artisan db:seed command to invoke the run command in database/seeds/DatabaseSeeder.php:

```
<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        $this->call(TaskSeeder::class);
    }
}
```

By running the seeder you now have ten tasks to play with in the database

```
$ php artisan db:seed
Seeding: TaskSeeder
Database seeding completed successfully.
```

To verify it works, you can use the Artisan Tinker command. This allows you to directly view and manipulate your database.

```
$ php artisan tinker
Psy Shell v0.9.9 (PHP 7.1.7 — cli) by Justin Hileman
>>> $tasks = \App\Task::all();
```

If all is well there will be ten records in the output with jibberish titles and descriptions. You could also view these records in a database viewing software such as Sequel Pro (for Mac).

### 1D. Write the test!

In the test for tasks we specify that we’d like to use DatabaseMigrations. This will set up our testing database from our migration files before the first test runs.

```
<?php

namespace Tests\Feature;

use App\Task;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Tests\TestCase;

class TaskTest extends TestCase
{
    use DatabaseMigrations;

    /** @test */
    public function it_will_show_all_tasks()
    {
        $tasks = factory(Task::class, 10)->create();

        $response = $this->get(route('tasks.index'));

        $response->assertStatus(200);

        $response->assertJson($tasks->toArray());
    }

    /** @test */
    public function it_will_create_tasks()
    {
        $response = $this->post(route('tasks.store'), [
            'title'       => 'This is a title',
            'description' => 'This is a description'
        ]);

        $response->assertStatus(200);

        $this->assertDatabaseHas('tasks', [
            'title' => 'This is a title'
        ]);

        $response->assertJsonStructure([
            'message',
            'task' => [
                'title',
                'description',
                'updated_at',
                'created_at',
                'id'
            ]
        ]);
    }

    /** @test */
    public function it_will_show_a_task()
    {
        $this->post(route('tasks.store'), [
            'title'       => 'This is a title',
            'description' => 'This is a description'
        ]);

        $task = Task::all()->first();

        $response = $this->get(route('tasks.show', $task->id));

        $response->assertStatus(200);

        $response->assertJson($task->toArray());
    }

    /** @test */
    public function it_will_update_a_task()
    {
        $this->post(route('tasks.store'), [
            'title'       => 'This is a title',
            'description' => 'This is a description'
        ]);

        $task = Task::all()->first();

        $response = $this->put(route('tasks.update', $task->id), [
            'title' => 'This is the updated title'
        ]);

        $response->assertStatus(200);

        $task = $task->fresh();

        $this->assertEquals($task->title, 'This is the updated title');

        $response->assertJsonStructure([
           'message',
           'task' => [
               'title',
               'description',
               'updated_at',
               'created_at',
               'id'
           ]
       ]);
    }

    /** @test */
    public function it_will_delete_a_task()
    {
        $this->post(route('tasks.store'), [
            'title'       => 'This is a title',
            'description' => 'This is a description'
        ]);

        $task = Task::all()->first();

        $response = $this->delete(route('tasks.destroy', $task->id));

        $task = $task->fresh();

        $this->assertNull($task);

        $response->assertJsonStructure([
            'message'
        ]);
    }
}
```

1『文件位置在「/meetup/tests/Feature/TaskTest.php」，要体会到测试的重要。』

In the above test we make a few different types of assertions about the JSON structure and content. The ->fresh() command will populate the data by running a new query. This is especially helpful for comparing data after we run the update or delete operations.

You can use dd() combined with getContent() to inspect the response values when you are writing your tests: dd($response->getContent());

1『

目前在浏览器里还是获取不了资源：http://localhost:8000/api/tasks/all。报错：

```
Illuminate\Database\QueryException
Database (database/database.sqlite) does not exist. (SQL: PRAGMA foreign_keys = ON;)
http://localhost:8000/api/tasks/all
```

确实在控制器里没有读取本地数据库的操作。

』
