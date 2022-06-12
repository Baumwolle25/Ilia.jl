abstract type Scene end

# my idea to follow DRY, but ugly to use...
mutable struct GenericSceneData
    int::Number
    vertexShaderSource
    fragmentShaderSource
    vertexID::Number
    fragmentID::Number
    shaderProgramm::Number
    GenericSceneData(int) = new(int)
end


mutable struct LevelEditorScene <: Scene
    Data::GenericSceneData
    LevelEditorScene() = new(GenericSceneData(1))
end

mutable struct LevelScene <: Scene
    Data::GenericSceneData
    LevelEditorScene() = new(GenericSceneData(2))
end

function changeScene(c, index::Int)
    if index == 1
        c.currentScene = LevelEditorScene()
    elseif index == 2
        c.currentScene = LevelScene()
    end
end

function initScene(c)
    c.currentScene.Data.vertexShaderSource = """
    #version 330 core
    layout (location=0) in vec3 aPos;
    layout (location=1) in vec4 aColor;

    out vec fColor;

    void main()
    {
        fColor = aColor;
        gl_Position = vec4(aPos, 1.0);
    }
    """
    c.currentScene.Data.fragmentShaderSource = """
    #version  330 core

    in vec4 fColor;

    out vec4 color;

    void main()
    {
        color = fColor;
    }
    """
end

function initScene(c, s::LevelEditorScene)
    initScene(c)
    s.Data.vertexID = glCreateShaderProgramv(GL_VERTEX_SHADER, 0, s.Data.vertexShaderSource)
    s.Data.fragmentID = glCreateShaderProgramv(GL_FRAGMENT_SHADER, 0, s.Data.fragmentShaderSource)

    glShaderSource(s.vertexID, s.vertexShaderSource)
end

function initScene(c, s::LevelScene)
    initScene(c)
end

function updateScene(c) end

function updateScene(c, s::LevelEditorScene)
    updateScene(c)
end

function updateScene(c, s::LevelScene)
    updateScene(c)
end
