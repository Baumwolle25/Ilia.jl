abstract type Scene end

mutable struct LevelEditorScene <:Scene
    int::Number
    LevelEditorScene() = new(1)
end

mutable struct LevelScene <:Scene
    int::Number
    LevelScene() = new(2)
end

function changeScene(c, index::Int)
    if index == 1
        c.currentScene = LevelEditorScene()
    elseif index == 2
        c.currentScene = LevelScene()
    end
end

function update(c)

end