# group and organize data
mutable struct Window
    width::Number
    heigth::Number
    title::String
    openGLpointer::GLFW.Window
    currentScene::Number
    xPos::Number
    yPos::Number
    maximized::Bool
    focused::Bool

    mouse::Mouse
    keyboard::Keyboard

    # openGLpointer & currentScene get initialized as ::Undef
    # standart empty consructor
    Window() = new(1280, 720, "Ilia.jl")
    # constructor with keyword arguments
    Window(; width=1280, heigth=720, title="Ilia.jl") = new(width, heigth, title)
end

function windowMaximized(w::Window, win, maximized)
    w.maximized = maximized
end

function windowFocused(w::Window, focused)
    w.focused = focused
end

function windowSize(w::Window, width, heigth)
    w.width, w.heigth = width, heigth
end

function windowPosition(w::Window, newX, newY)
    w.xPos, w.yPos = newX, newY
end

function windowClosing(w::Window) end