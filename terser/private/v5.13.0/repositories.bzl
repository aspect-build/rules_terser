"@generated by @aspect_rules_js//npm/private:npm_translate_lock.bzl from pnpm lock file @//:pnpm-lock.yaml"

load("@aspect_rules_js//npm:npm_import.bzl", "npm_import")

def npm_repositories():
    "Generated npm_import repository rules corresponding to npm packages in @//:pnpm-lock.yaml"
    npm_import(
        name = "npm__acorn__8.7.1",
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "acorn",
        version = "8.7.1",
        integrity = "sha512-Xx54uLJQZ19lKygFXOWsscKUbsBZW0CPykPhVQdhIeIwrbPmJzqeASDInc8nKBnp/JT6igTs82qPXz069H8I/A==",
        transitive_closure = {
            "acorn": ["8.7.1"],
        },
    )

    npm_import(
        name = "npm__buffer-from__1.1.2",
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "buffer-from",
        version = "1.1.2",
        integrity = "sha512-E+XQCRwSbaaiChtv6k6Dwgc+bx+Bs6vuKJHHl5kox/BaKbhiXzqQOwK4cO22yElGp2OCmjwVhT3HmxgyPGnJfQ==",
        transitive_closure = {
            "buffer-from": ["1.1.2"],
        },
    )

    npm_import(
        name = "npm__commander__2.20.3",
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "commander",
        version = "2.20.3",
        integrity = "sha512-GpVkmM8vF2vQUkj2LvZmD35JxeJOLCwJ9cUkugyk2nuhbv3+mJvpLYYt+0+USMxE+oj+ey/lJEnhZw75x/OMcQ==",
        transitive_closure = {
            "commander": ["2.20.3"],
        },
    )

    npm_import(
        name = "npm__lodash.sortby__4.7.0",
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "lodash.sortby",
        version = "4.7.0",
        integrity = "sha512-HDWXG8isMntAyRF5vZ7xKuEvOhT4AhlRt/3czTSjvGUxjYCBVRQY48ViDHyfYz9VIoBkW4TMGQNapx+l3RUwdA==",
        transitive_closure = {
            "lodash.sortby": ["4.7.0"],
        },
    )

    npm_import(
        name = "npm__punycode__2.1.1",
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "punycode",
        version = "2.1.1",
        integrity = "sha512-XRsRjdf+j5ml+y/6GKHPZbrF/8p2Yga0JPtdqTIY2Xe5ohJPD9saDJJLPvp9+NSBprVvevdXZybnj2cv8OEd0A==",
        transitive_closure = {
            "punycode": ["2.1.1"],
        },
    )

    npm_import(
        name = "npm__source-map-support__0.5.21",
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "source-map-support",
        version = "0.5.21",
        integrity = "sha512-uBHU3L3czsIyYXKX88fdrGovxdSCoTGDRZ6SYXtSRxLZUzHg5P/66Ht6uoUlHu9EZod+inXhKo3qQgwXUT/y1w==",
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
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "source-map",
        version = "0.6.1",
        integrity = "sha512-UjgapumWlbMhkBgzT7Ykc5YXUT46F0iKu8SGXq0bcwP5dz/h0Plj6enJqjz1Zbq2l5WaqYnrVbwWOWMyF3F47g==",
        transitive_closure = {
            "source-map": ["0.6.1"],
        },
    )

    npm_import(
        name = "npm__source-map__0.8.0-beta.0",
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "source-map",
        version = "0.8.0-beta.0",
        integrity = "sha512-2ymg6oRBpebeZi9UUNsgQ89bhx01TcTkmNTGnNO88imTmbSgy4nfujrgVEFKWpMTEGA11EDkTt7mqObTPdigIA==",
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
        root_package = "",
        link_workspace = "",
        link_packages = {
            "": ["terser"],
        },
        package = "terser",
        version = "5.13.0",
        integrity = "sha512-sgQ99P+fRBM1jAYzN9RTnD/xEWx/7LZgYTCRgmYriSq1wxxqiQPJgXkkLBBuwySDWJ2PP0PnVQyuf4xLUuH4Ng==",
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
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "tr46",
        version = "1.0.1",
        integrity = "sha512-dTpowEjclQ7Kgx5SdBkqRzVhERQXov8/l9Ft9dVM9fmg0W0KQSVaXX9T4i6twCPNtYiZM53lpSSUAwJbFPOHxA==",
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
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "webidl-conversions",
        version = "4.0.2",
        integrity = "sha512-YQ+BmxuTgd6UXZW3+ICGfyqRyHXVlD5GtQr5+qjiNW7bF0cqrzX500HVXPBOvgXb5YnzDd+h0zqyv61KUD7+Sg==",
        transitive_closure = {
            "webidl-conversions": ["4.0.2"],
        },
    )

    npm_import(
        name = "npm__whatwg-url__7.1.0",
        root_package = "",
        link_workspace = "",
        link_packages = {},
        package = "whatwg-url",
        version = "7.1.0",
        integrity = "sha512-WUu7Rg1DroM7oQvGWfOiAK21n74Gg+T4elXEQYkOhtyLeWiJFoOGLXPKI/9gzIie9CtwVLm8wtw6YJdKyxSjeg==",
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
