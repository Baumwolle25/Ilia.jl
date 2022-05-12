# group and organize data
mutable struct Window
    width::Number
    heigth::Number
    title::String
    openGLpointer::GLFW.Window
    currentScene::Number

    # openGLpointer & currentScene get initialized as ::Undef
    # standart empty consructor
    Window() = new(1280, 720, "Ilia.jl")
    # constructor with keyword arguments
    Window(; width=1280, heigth=720, title="Ilia.jl") = new(width, heigth, title)
end