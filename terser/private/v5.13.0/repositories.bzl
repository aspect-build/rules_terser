"@generated by @aspect_rules_js//js/private:translate_pnpm_lock.bzl from pnpm lock file @//:pnpm-lock.yaml"

load("@aspect_rules_js//js:npm_import.bzl", "npm_import")

def npm_repositories():
    "Generated npm_import repository rules corresponding to npm packages in @//:pnpm-lock.yaml"
    npm_import(
        name = "npm__acorn__8.7.1",
        integrity = "sha512-Xx54uLJQZ19lKygFXOWsscKUbsBZW0CPykPhVQdhIeIwrbPmJzqeASDInc8nKBnp/JT6igTs82qPXz069H8I/A==",
        root_path = "",
        link_paths = [],
        package = "acorn",
        version = "8.7.1",
        transitive_closure = {
            "acorn": ["8.7.1"],
        },
    )

    npm_import(
        name = "npm__buffer-from__1.1.2",
        integrity = "sha512-E+XQCRwSbaaiChtv6k6Dwgc+bx+Bs6vuKJHHl5kox/BaKbhiXzqQOwK4cO22yElGp2OCmjwVhT3HmxgyPGnJfQ==",
        root_path = "",
        link_paths = [],
        package = "buffer-from",
        version = "1.1.2",
        transitive_closure = {
            "buffer-from": ["1.1.2"],
        },
    )

    npm_import(
        name = "npm__commander__2.20.3",
        integrity = "sha512-GpVkmM8vF2vQUkj2LvZmD35JxeJOLCwJ9cUkugyk2nuhbv3+mJvpLYYt+0+USMxE+oj+ey/lJEnhZw75x/OMcQ==",
        root_path = "",
        link_paths = [],
        package = "commander",
        version = "2.20.3",
        transitive_closure = {
            "commander": ["2.20.3"],
        },
    )

    npm_import(
        name = "npm__lodash.sortby__4.7.0",
        integrity = "sha1-7dFMgk4sycHgsKG0K7UhBRakJDg=",
        root_path = "",
        link_paths = [],
        package = "lodash.sortby",
        version = "4.7.0",
        transitive_closure = {
            "lodash.sortby": ["4.7.0"],
        },
    )

    npm_import(
        name = "npm__punycode__2.1.1",
        integrity = "sha512-XRsRjdf+j5ml+y/6GKHPZbrF/8p2Yga0JPtdqTIY2Xe5ohJPD9saDJJLPvp9+NSBprVvevdXZybnj2cv8OEd0A==",
        root_path = "",
        link_paths = [],
        package = "punycode",
        version = "2.1.1",
        transitive_closure = {
            "punycode": ["2.1.1"],
        },
    )

    npm_import(
        name = "npm__source-map-support__0.5.21",
        integrity = "sha512-uBHU3L3czsIyYXKX88fdrGovxdSCoTGDRZ6SYXtSRxLZUzHg5P/66Ht6uoUlHu9EZod+inXhKo3qQgwXUT/y1w==",
        root_path = "",
        link_paths = [],
        package = "source-map-support",
        version = "0.5.21",
        deps = {
            "buffer-from": "1.1.2",
            "source-map": "0.6.1",
        },
        transitive_closure = {
            "source-map-support": ["0.5.21"],
            "buffer-from": ["1.1.2"],
            "source-map": ["0.6.1"],
        },
    )

    npm_import(
        name = "npm__source-map__0.6.1",
        integrity = "sha512-UjgapumWlbMhkBgzT7Ykc5YXUT46F0iKu8SGXq0bcwP5dz/h0Plj6enJqjz1Zbq2l5WaqYnrVbwWOWMyF3F47g==",
        root_path = "",
        link_paths = [],
        package = "source-map",
        version = "0.6.1",
        transitive_closure = {
            "source-map": ["0.6.1"],
        },
    )

    npm_import(
        name = "npm__source-map__0.8.0-beta.0",
        integrity = "sha512-2ymg6oRBpebeZi9UUNsgQ89bhx01TcTkmNTGnNO88imTmbSgy4nfujrgVEFKWpMTEGA11EDkTt7mqObTPdigIA==",
        root_path = "",
        link_paths = [],
        package = "source-map",
        version = "0.8.0-beta.0",
        deps = {
            "whatwg-url": "7.1.0",
        },
        transitive_closure = {
            "source-map": ["0.8.0-beta.0"],
            "whatwg-url": ["7.1.0"],
            "lodash.sortby": ["4.7.0"],
            "tr46": ["1.0.1"],
            "webidl-conversions": ["4.0.2"],
            "punycode": ["2.1.1"],
        },
    )

    npm_import(
        name = "npm__terser__5.13.0",
        integrity = "sha512-sgQ99P+fRBM1jAYzN9RTnD/xEWx/7LZgYTCRgmYriSq1wxxqiQPJgXkkLBBuwySDWJ2PP0PnVQyuf4xLUuH4Ng==",
        root_path = "",
        link_paths = ["."],
        package = "terser",
        version = "5.13.0",
        deps = {
            "acorn": "8.7.1",
            "commander": "2.20.3",
            "source-map": "0.8.0-beta.0",
            "source-map-support": "0.5.21",
        },
        transitive_closure = {
            "terser": ["5.13.0"],
            "acorn": ["8.7.1"],
            "commander": ["2.20.3"],
            "source-map": ["0.6.1", "0.8.0-beta.0"],
            "source-map-support": ["0.5.21"],
            "buffer-from": ["1.1.2"],
            "whatwg-url": ["7.1.0"],
            "lodash.sortby": ["4.7.0"],
            "tr46": ["1.0.1"],
            "webidl-conversions": ["4.0.2"],
            "punycode": ["2.1.1"],
        },
    )

    npm_import(
        name = "npm__tr46__1.0.1",
        integrity = "sha1-qLE/1r/SSJUZZ0zN5VujaTtwbQk=",
        root_path = "",
        link_paths = [],
        package = "tr46",
        version = "1.0.1",
        deps = {
            "punycode": "2.1.1",
        },
        transitive_closure = {
            "tr46": ["1.0.1"],
            "punycode": ["2.1.1"],
        },
    )

    npm_import(
        name = "npm__webidl-conversions__4.0.2",
        integrity = "sha512-YQ+BmxuTgd6UXZW3+ICGfyqRyHXVlD5GtQr5+qjiNW7bF0cqrzX500HVXPBOvgXb5YnzDd+h0zqyv61KUD7+Sg==",
        root_path = "",
        link_paths = [],
        package = "webidl-conversions",
        version = "4.0.2",
        transitive_closure = {
            "webidl-conversions": ["4.0.2"],
        },
    )

    npm_import(
        name = "npm__whatwg-url__7.1.0",
        integrity = "sha512-WUu7Rg1DroM7oQvGWfOiAK21n74Gg+T4elXEQYkOhtyLeWiJFoOGLXPKI/9gzIie9CtwVLm8wtw6YJdKyxSjeg==",
        root_path = "",
        link_paths = [],
        package = "whatwg-url",
        version = "7.1.0",
        deps = {
            "lodash.sortby": "4.7.0",
            "tr46": "1.0.1",
            "webidl-conversions": "4.0.2",
        },
        transitive_closure = {
            "whatwg-url": ["7.1.0"],
            "lodash.sortby": ["4.7.0"],
            "tr46": ["1.0.1"],
            "webidl-conversions": ["4.0.2"],
            "punycode": ["2.1.1"],
        },
    )
