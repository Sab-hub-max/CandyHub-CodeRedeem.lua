
--==================================================
-- AUTO CODE | DARK UI
-- Loading de 10s + interfaz principal + contador configurable
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local jugador = Players.LocalPlayer
if not jugador then
    warn("Auto Code necesita ejecutarse en el cliente.")
    return
end

local playerGui = jugador:WaitForChild("PlayerGui")

local anterior = playerGui:FindFirstChild("AutoCodeUI")
if anterior then
    anterior:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "AutoCodeUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

-- PALETA OSCURA
local fondo = Color3.fromRGB(16, 16, 20)
local panelInterior = Color3.fromRGB(26, 24, 32)
local bordeColor = Color3.fromRGB(67, 57, 82)
local morado = Color3.fromRGB(190, 164, 225)
local blanco = Color3.fromRGB(242, 239, 248)
local gris = Color3.fromRGB(139, 133, 151)

-- TIEMPO CONFIGURABLE
local tiempoCodigo = 60

local function crearEsquina(objeto, radio)
    local esquina = Instance.new("UICorner")
    esquina.CornerRadius = UDim.new(0, radio)
    esquina.Parent = objeto
    return esquina
end

local function crearBorde(objeto, color, grosor)
    local borde = Instance.new("UIStroke")
    borde.Color = color
    borde.Thickness = grosor or 1
    borde.Transparency = 0.12
    borde.Parent = objeto
    return borde
end

local function crearTexto(padre, nombre, texto, tamano, fuente, color)
    local label = Instance.new("TextLabel")
    label.Name = nombre
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextSize = tamano
    label.Font = fuente
    label.TextColor3 = color
    label.Parent = padre
    return label
end

local function crearBoton(padre, nombre, texto, posicion, tamano)
    local boton = Instance.new("TextButton")
    boton.Name = nombre
    boton.Position = posicion
    boton.Size = tamano
    boton.BackgroundColor3 = panelInterior
    boton.BorderSizePixel = 0
    boton.Text = texto
    boton.TextColor3 = blanco
    boton.TextSize = 11
    boton.Font = Enum.Font.GothamMedium
    boton.Parent = padre
    crearEsquina(boton, 6)
    return boton
end

--==================================================
-- VENTANA LOADING
--==================================================

local loading = Instance.new("Frame")
loading.Name = "VentanaLoading"
loading.AnchorPoint = Vector2.new(0.5, 0.5)
loading.Position = UDim2.fromScale(0.5, 0.5)
loading.Size = UDim2.fromOffset(250, 145)
loading.BackgroundColor3 = fondo
loading.BorderSizePixel = 0
loading.Parent = gui

crearEsquina(loading, 13)
crearBorde(loading, bordeColor, 1.3)

local tituloLoading = crearTexto(
    loading, "TituloLoading", "AUTO CODE",
    15, Enum.Font.GothamBold, blanco
)
tituloLoading.Position = UDim2.fromOffset(15, 10)
tituloLoading.Size = UDim2.new(1, -30, 0, 24)
tituloLoading.TextXAlignment = Enum.TextXAlignment.Left

local subtitulo = crearTexto(
    loading, "Subtitulo", "INITIALIZING SYSTEM",
    9, Enum.Font.GothamMedium, gris
)
subtitulo.Position = UDim2.fromOffset(15, 32)
subtitulo.Size = UDim2.new(1, -30, 0, 16)
subtitulo.TextXAlignment = Enum.TextXAlignment.Left

local separador = Instance.new("Frame")
separador.Position = UDim2.fromOffset(15, 54)
separador.Size = UDim2.new(1, -30, 0, 1)
separador.BackgroundColor3 = bordeColor
separador.BorderSizePixel = 0
separador.Parent = loading

local loadingTexto = crearTexto(
    loading, "LoadingTexto", "LOADING",
    11, Enum.Font.GothamBold, morado
)
loadingTexto.Position = UDim2.fromOffset(15, 61)
loadingTexto.Size = UDim2.new(1, -30, 0, 18)

local contadorLoading = crearTexto(
    loading, "ContadorLoading", "10s",
    25, Enum.Font.GothamBold, blanco
)
contadorLoading.Position = UDim2.fromOffset(15, 78)
contadorLoading.Size = UDim2.new(1, -30, 0, 32)

local barraFondo = Instance.new("Frame")
barraFondo.Position = UDim2.fromOffset(15, 117)
barraFondo.Size = UDim2.new(1, -30, 0, 4)
barraFondo.BackgroundColor3 = panelInterior
barraFondo.BorderSizePixel = 0
barraFondo.ClipsDescendants = true
barraFondo.Parent = loading
crearEsquina(barraFondo, 5)

local barra = Instance.new("Frame")
barra.Size = UDim2.fromScale(1, 1)
barra.BackgroundColor3 = morado
barra.BorderSizePixel = 0
barra.Parent = barraFondo
crearEsquina(barra, 5)

local esperaTexto = crearTexto(
    loading, "EsperaTexto", "PLEASE WAIT...",
    8, Enum.Font.GothamMedium, gris
)
esperaTexto.Position = UDim2.fromOffset(15, 124)
esperaTexto.Size = UDim2.new(1, -30, 0, 15)

--==================================================
-- INTERFAZ PRINCIPAL
--==================================================

local principal = Instance.new("Frame")
principal.Name = "PanelPrincipal"
principal.AnchorPoint = Vector2.new(1, 0)
principal.Position = UDim2.new(1, 320, 0, 18)
principal.Size = UDim2.fromOffset(265, 175)
principal.BackgroundColor3 = fondo
principal.BorderSizePixel = 0
principal.Visible = true
principal.Parent = gui

crearEsquina(principal, 13)
crearBorde(principal, bordeColor, 1.3)

local encabezado = Instance.new("Frame")
encabezado.Position = UDim2.fromOffset(12, 10)
encabezado.Size = UDim2.new(1, -24, 0, 30)
encabezado.BackgroundTransparency = 1
encabezado.Parent = principal

local icono = Instance.new("Frame")
icono.Size = UDim2.fromOffset(29, 29)
icono.BackgroundColor3 = panelInterior
icono.BorderSizePixel = 0
icono.Parent = encabezado
crearEsquina(icono, 8)

local simbolo = crearTexto(
    icono, "Simbolo", ">_",
    12, Enum.Font.Code, morado
)
simbolo.Size = UDim2.fromScale(1, 1)

local tituloPrincipal = crearTexto(
    encabezado, "TituloPrincipal", "Auto Code:",
    16, Enum.Font.GothamBold, blanco
)
tituloPrincipal.Position = UDim2.fromOffset(38, 0)
tituloPrincipal.Size = UDim2.new(1, -38, 1, 0)
tituloPrincipal.TextXAlignment = Enum.TextXAlignment.Left

local linea = Instance.new("Frame")
linea.Position = UDim2.fromOffset(12, 49)
linea.Size = UDim2.new(1, -24, 0, 1)
linea.BackgroundColor3 = bordeColor
linea.BorderSizePixel = 0
linea.Parent = principal

local rectangulo = Instance.new("Frame")
rectangulo.Name = "RectanguloCodigo"
rectangulo.Position = UDim2.fromOffset(12, 59)
rectangulo.Size = UDim2.new(1, -24, 0, 45)
rectangulo.BackgroundColor3 = panelInterior
rectangulo.BorderSizePixel = 0
rectangulo.Parent = principal

crearEsquina(rectangulo, 9)
crearBorde(rectangulo, Color3.fromRGB(53, 46, 65), 1)

local codigo = crearTexto(
    rectangulo, "TextoCodigo", "code is...",
    15, Enum.Font.Code, morado
)
codigo.Size = UDim2.fromScale(1, 1)

local pie = crearTexto(
    principal, "LeadingCode", "leading code 60s",
    11, Enum.Font.GothamMedium, gris
)
pie.Position = UDim2.fromOffset(13, 109)
pie.Size = UDim2.new(1, -26, 0, 22)
pie.TextXAlignment = Enum.TextXAlignment.Left

local indicador = Instance.new("Frame")
indicador.Position = UDim2.new(1, -9, 0, 116)
indicador.Size = UDim2.fromOffset(4, 4)
indicador.BackgroundColor3 = morado
indicador.BorderSizePixel = 0
indicador.Parent = principal
crearEsquina(indicador, 5)

--==================================================
-- BOTON FLOTANTE ABRIR / CERRAR
--==================================================

local botonFlotante = Instance.new("TextButton")
botonFlotante.Name = "BotonFlotante"
botonFlotante.AnchorPoint = Vector2.new(0, 0)
botonFlotante.Position = UDim2.new(0, 12, 0, 18)
botonFlotante.Size = UDim2.fromOffset(42, 42)
botonFlotante.BackgroundColor3 = fondo
botonFlotante.BorderSizePixel = 0
botonFlotante.Text = "≡"
botonFlotante.TextColor3 = morado
botonFlotante.TextSize = 25
botonFlotante.Font = Enum.Font.GothamBold
botonFlotante.Visible = false
botonFlotante.AutoButtonColor = true
botonFlotante.Parent = gui

crearEsquina(botonFlotante, 11)
crearBorde(botonFlotante, bordeColor, 1.3)

--==================================================
-- BOTON SETTINGS EN LA PARTE INFERIOR
--==================================================

local botonSettings = Instance.new("TextButton")
botonSettings.Name = "BotonSettings"
botonSettings.Position = UDim2.new(0, 12, 1, -36)
botonSettings.Size = UDim2.new(1, -24, 0, 26)
botonSettings.BackgroundColor3 = panelInterior
botonSettings.BorderSizePixel = 0
botonSettings.Text = ""
botonSettings.Parent = principal

crearEsquina(botonSettings, 7)
crearBorde(botonSettings, bordeColor, 1)

local iconoSettings = crearTexto(
    botonSettings, "IconoSettings", "⚙",
    15, Enum.Font.GothamBold, morado
)
iconoSettings.Position = UDim2.new(0.5, -37, 0, 0)
iconoSettings.Size = UDim2.fromOffset(22, 26)

local textoSettings = crearTexto(
    botonSettings, "TextoSettings", "Settings",
    11, Enum.Font.GothamBold, blanco
)
textoSettings.Position = UDim2.new(0.5, -12, 0, 0)
textoSettings.Size = UDim2.fromOffset(65, 26)
textoSettings.TextXAlignment = Enum.TextXAlignment.Left

--==================================================
-- PANEL DE AJUSTES
--==================================================

local ajustes = Instance.new("Frame")
ajustes.Name = "PanelAjustes"
ajustes.AnchorPoint = Vector2.new(1, 0)
ajustes.Position = UDim2.new(1, -12, 0, 201)
ajustes.Size = UDim2.fromOffset(265, 174)
ajustes.BackgroundColor3 = fondo
ajustes.BorderSizePixel = 0
ajustes.Visible = false
ajustes.Parent = gui

crearEsquina(ajustes, 12)
crearBorde(ajustes, bordeColor, 1.3)

local tituloAjustes = crearTexto(
    ajustes, "TituloAjustes", "Settings",
    14, Enum.Font.GothamBold, blanco
)
tituloAjustes.Position = UDim2.fromOffset(12, 7)
tituloAjustes.Size = UDim2.new(1, -24, 0, 22)
tituloAjustes.TextXAlignment = Enum.TextXAlignment.Left

-- COLOR

local etiquetaColor = crearTexto(
    ajustes, "EtiquetaColor", "Color",
    11, Enum.Font.GothamMedium, gris
)
etiquetaColor.Position = UDim2.fromOffset(12, 34)
etiquetaColor.Size = UDim2.fromOffset(55, 22)
etiquetaColor.TextXAlignment = Enum.TextXAlignment.Left

local colores = {
    {Nombre = "Morado", Color = Color3.fromRGB(190, 164, 225)},
    {Nombre = "Azul", Color = Color3.fromRGB(100, 170, 255)},
    {Nombre = "Rojo", Color = Color3.fromRGB(255, 105, 115)},
    {Nombre = "Verde", Color = Color3.fromRGB(100, 220, 160)},
}

local botonesColores = {}

for i, datos in ipairs(colores) do
    local boton = crearBoton(
        ajustes,
        "Color" .. datos.Nombre,
        "",
        UDim2.fromOffset(68 + (i - 1) * 46, 34),
        UDim2.fromOffset(38, 22)
    )
    boton.BackgroundColor3 = datos.Color
    botonesColores[i] = boton
end

-- TIEMPO DE CODIGO

local etiquetaTiempo = crearTexto(
    ajustes, "EtiquetaTiempo", "Code Time",
    11, Enum.Font.GothamMedium, gris
)
etiquetaTiempo.Position = UDim2.fromOffset(12, 64)
etiquetaTiempo.Size = UDim2.fromOffset(112, 24)
etiquetaTiempo.TextXAlignment = Enum.TextXAlignment.Left

local entradaTiempo = Instance.new("TextBox")
entradaTiempo.Name = "TiempoCodigo"
entradaTiempo.Position = UDim2.fromOffset(165, 64)
entradaTiempo.Size = UDim2.fromOffset(87, 24)
entradaTiempo.BackgroundColor3 = panelInterior
entradaTiempo.BorderSizePixel = 0
entradaTiempo.Text = "60"
entradaTiempo.PlaceholderText = "Seconds"
entradaTiempo.TextColor3 = blanco
entradaTiempo.PlaceholderColor3 = gris
entradaTiempo.TextSize = 12
entradaTiempo.Font = Enum.Font.GothamMedium
entradaTiempo.ClearTextOnFocus = false
entradaTiempo.Parent = ajustes

crearEsquina(entradaTiempo, 6)

-- TAMAÑO

local etiquetaTamano = crearTexto(
    ajustes, "EtiquetaTamano", "Size",
    11, Enum.Font.GothamMedium, gris
)
etiquetaTamano.Position = UDim2.fromOffset(12, 98)
etiquetaTamano.Size = UDim2.fromOffset(55, 24)
etiquetaTamano.TextXAlignment = Enum.TextXAlignment.Left

local botonPequeno = crearBoton(
    ajustes, "TamanoPequeno", "Small",
    UDim2.fromOffset(68, 98),
    UDim2.fromOffset(57, 24)
)

local botonNormal = crearBoton(
    ajustes, "TamanoNormal", "Normal",
    UDim2.fromOffset(130, 98),
    UDim2.fromOffset(57, 24)
)

local botonGrande = crearBoton(
    ajustes, "TamanoGrande", "Large",
    UDim2.fromOffset(192, 98),
    UDim2.fromOffset(60, 24)
)

local botonCerrarAjustes = crearBoton(
    ajustes, "CerrarAjustes", "Close",
    UDim2.fromOffset(12, 137),
    UDim2.new(1, -24, 0, 25)
)

--==================================================
-- FUNCIONES DE AJUSTES
--==================================================

local tamanoOriginal = UDim2.fromOffset(265, 175)
local colorActual = morado

local function cambiarColor(color)
    colorActual = color

    codigo.TextColor3 = color
    simbolo.TextColor3 = color
    indicador.BackgroundColor3 = color
    botonFlotante.TextColor3 = color
    barra.BackgroundColor3 = color
    iconoSettings.TextColor3 = color

    crearBorde(principal, color, 1.3)
    crearBorde(botonFlotante, color, 1.3)
    crearBorde(ajustes, color, 1.3)
    crearBorde(botonSettings, color, 1)

    tituloAjustes.TextColor3 = blanco
end

for i, datos in ipairs(colores) do
    botonesColores[i].MouseButton1Click:Connect(function()
        cambiarColor(datos.Color)
    end)
end

local function cambiarTamano(multiplicador)
    principal.Size = UDim2.fromOffset(
        tamanoOriginal.X.Offset * multiplicador,
        tamanoOriginal.Y.Offset * multiplicador
    )
end

botonPequeno.MouseButton1Click:Connect(function()
    cambiarTamano(0.85)
end)

botonNormal.MouseButton1Click:Connect(function()
    cambiarTamano(1)
end)

botonGrande.MouseButton1Click:Connect(function()
    cambiarTamano(1.15)
end)

-- ACTUALIZAR EL TIEMPO FUNCIONAL

entradaTiempo.FocusLost:Connect(function()
    local numero = tonumber(entradaTiempo.Text)

    if not numero or numero < 1 then
        entradaTiempo.Text = tostring(tiempoCodigo)
        return
    end

    tiempoCodigo = math.clamp(math.floor(numero), 1, 3600)
    entradaTiempo.Text = tostring(tiempoCodigo)
end)

-- ABRIR / CERRAR AJUSTES

botonSettings.MouseButton1Click:Connect(function()
    ajustes.Visible = not ajustes.Visible
end)

botonCerrarAjustes.MouseButton1Click:Connect(function()
    ajustes.Visible = false
end)

-- ABRIR / CERRAR INTERFAZ CON EL BOTON FLOTANTE

botonFlotante.MouseButton1Click:Connect(function()
    principal.Visible = not principal.Visible
    ajustes.Visible = false
end)

--==================================================
-- CONTADOR DE LOADING Y TRANSICION
--==================================================

for segundos = 10, 0, -1 do
    if not gui.Parent then return end

    contadorLoading.Text = segundos .. "s"

    TweenService:Create(
        barra,
        TweenInfo.new(1, Enum.EasingStyle.Linear),
        {Size = UDim2.fromScale(segundos / 10, 1)}
    ):Play()

    if segundos > 0 then
        task.wait(1)
    end
end

local salida = TweenService:Create(
    loading,
    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    {
        Position = UDim2.fromScale(0.5, 0.46),
        BackgroundTransparency = 1
    }
)

salida:Play()
salida.Completed:Wait()

if not gui.Parent then return end
loading:Destroy()

-- ENTRADA DE LA INTERFAZ PRINCIPAL

TweenService:Create(
    principal,
    TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    {Position = UDim2.new(1, -12, 0, 18)}
):Play()

botonFlotante.Visible = true

--==================================================
-- CONTADOR REPETITIVO CON TIEMPO CONFIGURABLE
--==================================================

task.spawn(function()
    while gui.Parent and principal.Parent do
        local duracion = tiempoCodigo

        for segundos = duracion, 0, -1 do
            if not gui.Parent then return end

            -- Si el usuario cambia el tiempo, reinicia el ciclo
            -- con la nueva duración.
            if tiempoCodigo ~= duracion then
                break
            end

            pie.Text = "leading code " .. segundos .. "s"

            if segundos > 0 then
                task.wait(1)
            end
        end
    end
end)

print("Auto Code UI cargada.")
