# taskMan - task manager 
### Usage
1. Clone project: <pre><code>git clone https://github.com/floor114/task_manager.git</code></pre>

2. Rename <code>application.yml.example</code> to <code>application.yml</code>, enter gmail account for possibility to confirm user accounts via email.

3. Rename <code>database.yml.example</code> to <code>database.yml</code>, enter postgres username and password for setup database settings.

4. Execute: <code>rake db:setup</code> for creating database, run migrations and seeds.

5. There are three default users with same password (12345678):
 * zero@user.com
 * one@user.com
 * two@user.com 
