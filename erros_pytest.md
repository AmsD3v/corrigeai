(.venv) I:\siteai\backend>pytest
=========================================================================================================== test session starts ============================================================================================================
platform win32 -- Python 3.10.11, pytest-9.0.1, pluggy-1.6.0
rootdir: I:\siteai\backend
plugins: anyio-4.11.0, asyncio-1.3.0
asyncio: mode=strict, debug=False, asyncio_default_fixture_loop_scope=None, asyncio_default_test_loop_scope=function
collected 5 items

tests\test_authentication.py ..FFF                                                                                                                                                                                                    [100%]

================================================================================================================= FAILURES =================================================================================================================
____________________________________________________________________________________________________________ test_login_success ____________________________________________________________________________________________________________

client = <starlette.testclient.TestClient object at 0x0000014AFA7B1C90>, test_user_data = UserCreate(email='test@example.com', full_name='Test User', password='TestPass123!')

    def test_login_success(client: TestClient, test_user_data):
        # Primeiro, registra o usuário
        client.post("/register", json=test_user_data.model_dump())

        login_data = {"username": test_user_data.email, "password": test_user_data.password}
>       response = client.post("/login", json=login_data) # <--- CORRIGIDO: de 'data' para 'json'

tests\test_authentication.py:33:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
.venv\lib\site-packages\starlette\testclient.py:552: in post
    return super().post(
.venv\lib\site-packages\httpx\_client.py:1144: in post
    return self.request(
.venv\lib\site-packages\starlette\testclient.py:451: in request
    return super().request(
.venv\lib\site-packages\httpx\_client.py:825: in request
    return self.send(request, auth=auth, follow_redirects=follow_redirects)
.venv\lib\site-packages\httpx\_client.py:914: in send
    response = self._send_handling_auth(
.venv\lib\site-packages\httpx\_client.py:942: in _send_handling_auth
    response = self._send_handling_redirects(
.venv\lib\site-packages\httpx\_client.py:979: in _send_handling_redirects
    response = self._send_single_request(request)
.venv\lib\site-packages\httpx\_client.py:1014: in _send_single_request
    response = transport.handle_request(request)
.venv\lib\site-packages\starlette\testclient.py:354: in handle_request
    raise exc
.venv\lib\site-packages\starlette\testclient.py:351: in handle_request
    portal.call(self.app, scope, receive, send)
.venv\lib\site-packages\anyio\from_thread.py:321: in call
    return cast(T_Retval, self.start_task_soon(func, *args).result())
C:\Program Files\Python310\lib\concurrent\futures\_base.py:458: in result
    return self.__get_result()
C:\Program Files\Python310\lib\concurrent\futures\_base.py:403: in __get_result
    raise self._exception
.venv\lib\site-packages\anyio\from_thread.py:252: in _call_func
    retval = await retval_or_awaitable
.venv\lib\site-packages\fastapi\applications.py:1134: in __call__
    await super().__call__(scope, receive, send)
.venv\lib\site-packages\starlette\applications.py:113: in __call__
    await self.middleware_stack(scope, receive, send)
.venv\lib\site-packages\starlette\middleware\errors.py:186: in __call__
    raise exc
.venv\lib\site-packages\starlette\middleware\errors.py:164: in __call__
    await self.app(scope, receive, _send)
.venv\lib\site-packages\starlette\middleware\exceptions.py:63: in __call__
    await wrap_app_handling_exceptions(self.app, conn)(scope, receive, send)
.venv\lib\site-packages\starlette\_exception_handler.py:53: in wrapped_app
    raise exc
.venv\lib\site-packages\starlette\_exception_handler.py:42: in wrapped_app
    await app(scope, receive, sender)
.venv\lib\site-packages\fastapi\middleware\asyncexitstack.py:18: in __call__
    await self.app(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:716: in __call__
    await self.middleware_stack(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:736: in app
    await route.handle(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:290: in handle
    await self.app(scope, receive, send)
.venv\lib\site-packages\fastapi\routing.py:125: in app
    await wrap_app_handling_exceptions(app, request)(scope, receive, send)
.venv\lib\site-packages\starlette\_exception_handler.py:53: in wrapped_app
    raise exc
.venv\lib\site-packages\starlette\_exception_handler.py:42: in wrapped_app
    await app(scope, receive, sender)
.venv\lib\site-packages\fastapi\routing.py:111: in app
    response = await f(request)
.venv\lib\site-packages\fastapi\routing.py:391: in app
    raw_response = await run_endpoint_function(
.venv\lib\site-packages\fastapi\routing.py:292: in run_endpoint_function
    return await run_in_threadpool(dependant.call, **values)
.venv\lib\site-packages\starlette\concurrency.py:38: in run_in_threadpool
    return await anyio.to_thread.run_sync(func)
.venv\lib\site-packages\anyio\to_thread.py:56: in run_sync
    return await get_async_backend().run_sync_in_worker_thread(
.venv\lib\site-packages\anyio\_backends\_asyncio.py:2485: in run_sync_in_worker_thread
    return await future
.venv\lib\site-packages\anyio\_backends\_asyncio.py:976: in run
    result = context.run(func, *args)
src\main.py:88: in login_user
    db_user = db.query(User).filter(User.email == user.email).first()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

self = UserLogin(username='test@example.com', password='TestPass123!'), item = 'email'

    def __getattr__(self, item: str) -> Any:
        private_attributes = object.__getattribute__(self, '__private_attributes__')
        if item in private_attributes:
            attribute = private_attributes[item]
            if hasattr(attribute, '__get__'):
                return attribute.__get__(self, type(self))  # type: ignore

            try:
                # Note: self.__pydantic_private__ cannot be None if self.__private_attributes__ has items
                return self.__pydantic_private__[item]  # type: ignore
            except KeyError as exc:
                raise AttributeError(f'{type(self).__name__!r} object has no attribute {item!r}') from exc
        else:
            # `__pydantic_extra__` can fail to be set if the model is not yet fully initialized.
            # See `BaseModel.__repr_args__` for more details
            try:
                pydantic_extra = object.__getattribute__(self, '__pydantic_extra__')
            except AttributeError:
                pydantic_extra = None

            if pydantic_extra and item in pydantic_extra:
                return pydantic_extra[item]
            else:
                if hasattr(self.__class__, item):
                    return super().__getattribute__(item)  # Raises AttributeError if appropriate
                else:
                    # this is the current error
>                   raise AttributeError(f'{type(self).__name__!r} object has no attribute {item!r}')
E                   AttributeError: 'UserLogin' object has no attribute 'email'

.venv\lib\site-packages\pydantic\main.py:1026: AttributeError
______________________________________________________________________________________________________ test_login_invalid_credentials ______________________________________________________________________________________________________

client = <starlette.testclient.TestClient object at 0x0000014AFB07BAF0>, test_user_data = UserCreate(email='test@example.com', full_name='Test User', password='TestPass123!')

    def test_login_invalid_credentials(client: TestClient, test_user_data):
        # Primeiro, registra o usuário para que exista um na base
        client.post("/register", json=test_user_data.model_dump())

        login_data = {"username": test_user_data.email, "password": "wrongpassword"}
>       response = client.post("/login", json=login_data) # <--- CORRIGIDO: de 'data' para 'json'

tests\test_authentication.py:45:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
.venv\lib\site-packages\starlette\testclient.py:552: in post
    return super().post(
.venv\lib\site-packages\httpx\_client.py:1144: in post
    return self.request(
.venv\lib\site-packages\starlette\testclient.py:451: in request
    return super().request(
.venv\lib\site-packages\httpx\_client.py:825: in request
    return self.send(request, auth=auth, follow_redirects=follow_redirects)
.venv\lib\site-packages\httpx\_client.py:914: in send
    response = self._send_handling_auth(
.venv\lib\site-packages\httpx\_client.py:942: in _send_handling_auth
    response = self._send_handling_redirects(
.venv\lib\site-packages\httpx\_client.py:979: in _send_handling_redirects
    response = self._send_single_request(request)
.venv\lib\site-packages\httpx\_client.py:1014: in _send_single_request
    response = transport.handle_request(request)
.venv\lib\site-packages\starlette\testclient.py:354: in handle_request
    raise exc
.venv\lib\site-packages\starlette\testclient.py:351: in handle_request
    portal.call(self.app, scope, receive, send)
.venv\lib\site-packages\anyio\from_thread.py:321: in call
    return cast(T_Retval, self.start_task_soon(func, *args).result())
C:\Program Files\Python310\lib\concurrent\futures\_base.py:458: in result
    return self.__get_result()
C:\Program Files\Python310\lib\concurrent\futures\_base.py:403: in __get_result
    raise self._exception
.venv\lib\site-packages\anyio\from_thread.py:252: in _call_func
    retval = await retval_or_awaitable
.venv\lib\site-packages\fastapi\applications.py:1134: in __call__
    await super().__call__(scope, receive, send)
.venv\lib\site-packages\starlette\applications.py:113: in __call__
    await self.middleware_stack(scope, receive, send)
.venv\lib\site-packages\starlette\middleware\errors.py:186: in __call__
    raise exc
.venv\lib\site-packages\starlette\middleware\errors.py:164: in __call__
    await self.app(scope, receive, _send)
.venv\lib\site-packages\starlette\middleware\exceptions.py:63: in __call__
    await wrap_app_handling_exceptions(self.app, conn)(scope, receive, send)
.venv\lib\site-packages\starlette\_exception_handler.py:53: in wrapped_app
    raise exc
.venv\lib\site-packages\starlette\_exception_handler.py:42: in wrapped_app
    await app(scope, receive, sender)
.venv\lib\site-packages\fastapi\middleware\asyncexitstack.py:18: in __call__
    await self.app(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:716: in __call__
    await self.middleware_stack(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:736: in app
    await route.handle(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:290: in handle
    await self.app(scope, receive, send)
.venv\lib\site-packages\fastapi\routing.py:125: in app
    await wrap_app_handling_exceptions(app, request)(scope, receive, send)
.venv\lib\site-packages\starlette\_exception_handler.py:53: in wrapped_app
    raise exc
.venv\lib\site-packages\starlette\_exception_handler.py:42: in wrapped_app
    await app(scope, receive, sender)
.venv\lib\site-packages\fastapi\routing.py:111: in app
    response = await f(request)
.venv\lib\site-packages\fastapi\routing.py:391: in app
    raw_response = await run_endpoint_function(
.venv\lib\site-packages\fastapi\routing.py:292: in run_endpoint_function
    return await run_in_threadpool(dependant.call, **values)
.venv\lib\site-packages\starlette\concurrency.py:38: in run_in_threadpool
    return await anyio.to_thread.run_sync(func)
.venv\lib\site-packages\anyio\to_thread.py:56: in run_sync
    return await get_async_backend().run_sync_in_worker_thread(
.venv\lib\site-packages\anyio\_backends\_asyncio.py:2485: in run_sync_in_worker_thread
    return await future
.venv\lib\site-packages\anyio\_backends\_asyncio.py:976: in run
    result = context.run(func, *args)
src\main.py:88: in login_user
    db_user = db.query(User).filter(User.email == user.email).first()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

self = UserLogin(username='test@example.com', password='wrongpassword'), item = 'email'

    def __getattr__(self, item: str) -> Any:
        private_attributes = object.__getattribute__(self, '__private_attributes__')
        if item in private_attributes:
            attribute = private_attributes[item]
            if hasattr(attribute, '__get__'):
                return attribute.__get__(self, type(self))  # type: ignore

            try:
                # Note: self.__pydantic_private__ cannot be None if self.__private_attributes__ has items
                return self.__pydantic_private__[item]  # type: ignore
            except KeyError as exc:
                raise AttributeError(f'{type(self).__name__!r} object has no attribute {item!r}') from exc
        else:
            # `__pydantic_extra__` can fail to be set if the model is not yet fully initialized.
            # See `BaseModel.__repr_args__` for more details
            try:
                pydantic_extra = object.__getattribute__(self, '__pydantic_extra__')
            except AttributeError:
                pydantic_extra = None

            if pydantic_extra and item in pydantic_extra:
                return pydantic_extra[item]
            else:
                if hasattr(self.__class__, item):
                    return super().__getattribute__(item)  # Raises AttributeError if appropriate
                else:
                    # this is the current error
>                   raise AttributeError(f'{type(self).__name__!r} object has no attribute {item!r}')
E                   AttributeError: 'UserLogin' object has no attribute 'email'

.venv\lib\site-packages\pydantic\main.py:1026: AttributeError
_______________________________________________________________________________________________________ test_login_non_existent_user _______________________________________________________________________________________________________

client = <starlette.testclient.TestClient object at 0x0000014AFB246AD0>

    def test_login_non_existent_user(client: TestClient):
        login_data = {"username": "nonexistent@example.com", "password": "anypassword"}
>       response = client.post("/login", json=login_data) # <--- CORRIGIDO: de 'data' para 'json'

tests\test_authentication.py:52:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
.venv\lib\site-packages\starlette\testclient.py:552: in post
    return super().post(
.venv\lib\site-packages\httpx\_client.py:1144: in post
    return self.request(
.venv\lib\site-packages\starlette\testclient.py:451: in request
    return super().request(
.venv\lib\site-packages\httpx\_client.py:825: in request
    return self.send(request, auth=auth, follow_redirects=follow_redirects)
.venv\lib\site-packages\httpx\_client.py:914: in send
    response = self._send_handling_auth(
.venv\lib\site-packages\httpx\_client.py:942: in _send_handling_auth
    response = self._send_handling_redirects(
.venv\lib\site-packages\httpx\_client.py:979: in _send_handling_redirects
    response = self._send_single_request(request)
.venv\lib\site-packages\httpx\_client.py:1014: in _send_single_request
    response = transport.handle_request(request)
.venv\lib\site-packages\starlette\testclient.py:354: in handle_request
    raise exc
.venv\lib\site-packages\starlette\testclient.py:351: in handle_request
    portal.call(self.app, scope, receive, send)
.venv\lib\site-packages\anyio\from_thread.py:321: in call
    return cast(T_Retval, self.start_task_soon(func, *args).result())
C:\Program Files\Python310\lib\concurrent\futures\_base.py:458: in result
    return self.__get_result()
C:\Program Files\Python310\lib\concurrent\futures\_base.py:403: in __get_result
    raise self._exception
.venv\lib\site-packages\anyio\from_thread.py:252: in _call_func
    retval = await retval_or_awaitable
.venv\lib\site-packages\fastapi\applications.py:1134: in __call__
    await super().__call__(scope, receive, send)
.venv\lib\site-packages\starlette\applications.py:113: in __call__
    await self.middleware_stack(scope, receive, send)
.venv\lib\site-packages\starlette\middleware\errors.py:186: in __call__
    raise exc
.venv\lib\site-packages\starlette\middleware\errors.py:164: in __call__
    await self.app(scope, receive, _send)
.venv\lib\site-packages\starlette\middleware\exceptions.py:63: in __call__
    await wrap_app_handling_exceptions(self.app, conn)(scope, receive, send)
.venv\lib\site-packages\starlette\_exception_handler.py:53: in wrapped_app
    raise exc
.venv\lib\site-packages\starlette\_exception_handler.py:42: in wrapped_app
    await app(scope, receive, sender)
.venv\lib\site-packages\fastapi\middleware\asyncexitstack.py:18: in __call__
    await self.app(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:716: in __call__
    await self.middleware_stack(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:736: in app
    await route.handle(scope, receive, send)
.venv\lib\site-packages\starlette\routing.py:290: in handle
    await self.app(scope, receive, send)
.venv\lib\site-packages\fastapi\routing.py:125: in app
    await wrap_app_handling_exceptions(app, request)(scope, receive, send)
.venv\lib\site-packages\starlette\_exception_handler.py:53: in wrapped_app
    raise exc
.venv\lib\site-packages\starlette\_exception_handler.py:42: in wrapped_app
    await app(scope, receive, sender)
.venv\lib\site-packages\fastapi\routing.py:111: in app
    response = await f(request)
.venv\lib\site-packages\fastapi\routing.py:391: in app
    raw_response = await run_endpoint_function(
.venv\lib\site-packages\fastapi\routing.py:292: in run_endpoint_function
    return await run_in_threadpool(dependant.call, **values)
.venv\lib\site-packages\starlette\concurrency.py:38: in run_in_threadpool
    return await anyio.to_thread.run_sync(func)
.venv\lib\site-packages\anyio\to_thread.py:56: in run_sync
    return await get_async_backend().run_sync_in_worker_thread(
.venv\lib\site-packages\anyio\_backends\_asyncio.py:2485: in run_sync_in_worker_thread
    return await future
.venv\lib\site-packages\anyio\_backends\_asyncio.py:976: in run
    result = context.run(func, *args)
src\main.py:88: in login_user
    db_user = db.query(User).filter(User.email == user.email).first()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

self = UserLogin(username='nonexistent@example.com', password='anypassword'), item = 'email'

    def __getattr__(self, item: str) -> Any:
        private_attributes = object.__getattribute__(self, '__private_attributes__')
        if item in private_attributes:
            attribute = private_attributes[item]
            if hasattr(attribute, '__get__'):
                return attribute.__get__(self, type(self))  # type: ignore

            try:
                # Note: self.__pydantic_private__ cannot be None if self.__private_attributes__ has items
                return self.__pydantic_private__[item]  # type: ignore
            except KeyError as exc:
                raise AttributeError(f'{type(self).__name__!r} object has no attribute {item!r}') from exc
        else:
            # `__pydantic_extra__` can fail to be set if the model is not yet fully initialized.
            # See `BaseModel.__repr_args__` for more details
            try:
                pydantic_extra = object.__getattribute__(self, '__pydantic_extra__')
            except AttributeError:
                pydantic_extra = None

            if pydantic_extra and item in pydantic_extra:
                return pydantic_extra[item]
            else:
                if hasattr(self.__class__, item):
                    return super().__getattribute__(item)  # Raises AttributeError if appropriate
                else:
                    # this is the current error
>                   raise AttributeError(f'{type(self).__name__!r} object has no attribute {item!r}')
E                   AttributeError: 'UserLogin' object has no attribute 'email'

.venv\lib\site-packages\pydantic\main.py:1026: AttributeError
========================================================================================================= short test summary info ==========================================================================================================
FAILED tests/test_authentication.py::test_login_success - AttributeError: 'UserLogin' object has no attribute 'email'
FAILED tests/test_authentication.py::test_login_invalid_credentials - AttributeError: 'UserLogin' object has no attribute 'email'
FAILED tests/test_authentication.py::test_login_non_existent_user - AttributeError: 'UserLogin' object has no attribute 'email'
======================================================================================================= 3 failed, 2 passed in 2.23s ========================================================================================================

(.venv) I:\siteai\backend>pytest
=========================================================================================================== test session starts ============================================================================================================
platform win32 -- Python 3.10.11, pytest-9.0.1, pluggy-1.6.0
rootdir: I:\siteai\backend
plugins: anyio-4.11.0, asyncio-1.3.0
asyncio: mode=strict, debug=False, asyncio_default_fixture_loop_scope=None, asyncio_default_test_loop_scope=function
collected 5 items

tests\test_authentication.py .....                                                                                                                                                                                                    [100%]

============================================================================================================ 5 passed in 1.61s =============================================================================================================

(.venv) I:\siteai\backend>pytest
=========================================================================================================== test session starts ============================================================================================================
platform win32 -- Python 3.10.11, pytest-9.0.1, pluggy-1.6.0
rootdir: I:\siteai\backend
plugins: anyio-4.11.0, asyncio-1.3.0
asyncio: mode=strict, debug=False, asyncio_default_fixture_loop_scope=None, asyncio_default_test_loop_scope=function
collected 5 items

tests\test_authentication.py .....                                                                                                                                                                                                    [100%]

============================================================================================================ 5 passed in 1.61s =============================================================================================================