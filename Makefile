
build-frontend:
	cd frontend && npm run build

copy-frontend:
	rm -rf server/static/static/* && cp -r frontend/dist/* server/static/static/

run-server:
	cd server && go run main.go

dev:
	cd server && go run main.go & cd ../frontend && npm run dev

docker:
	docker build . -t mayfly-go