import astroid
from pylint.checkers import BaseChecker
from pylint.lint import PyLinter
from astroid.exceptions import InferenceError


EXCEPTIONS = [
    'loop.run_until_complete',
    'loop.run_forever',
    'asyncio.run',
    'asyncio.gather',
    'asyncio.create_task',
    'asyncio.ensure_future',
]


def register(linter: PyLinter):
    linter.register_checker(AsyncAwaitChecker(linter))


class AsyncAwaitChecker(BaseChecker):
    name = 'async_await_checker'
    MESSAGE_ID = 'non-awaited-async'
    msgs = {
        'E1337': (
            "async function %s() must be awaited",
            MESSAGE_ID,
            "async functions must be awaited",
        ),
    }

    def visit_call(self, node):
        try:
            inferred = node.func.inferred()
        except InferenceError:
            return

        for func_def in inferred:
            if (
                isinstance(func_def, astroid.AsyncFunctionDef)
                and not isinstance(node.parent, astroid.Await)
                and not self._is_exception(node)
            ):
                self.add_message(self.MESSAGE_ID, args=(func_def.name,), node=node)

    def _is_exception(self, node):
        parent = node.parent
        try:
            return parent.func.as_string().lower() in EXCEPTIONS
        except AttributeError:
            return False
